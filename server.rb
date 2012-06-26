require 'erb'
require 'webrick'
require 'optparse'

# Pull out port
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby server.rb [options]"

  options[:port] = 8000
  opts.on("-p", "--port [PORT]", Integer, "port to run server on") do |p|
    options[:port] = p || 8000
  end
end.parse!


root = File.expand_path 'public'


# Define Server
server = WEBrick::HTTPServer.new :Port => options[:port], :DocumentRoot => root

# erb helper method
def process_erb(string)
  template = ERB.new(string)
  return template.result(binding)
end

# redirect the `/` path to `/index`
server.mount_proc "/" do |req, res|
  res.set_redirect(WEBrick::HTTPStatus::MovedPermanently, '/index')
end

# Loop through all files in the /views directory
# mount routes at the same file name so me.html.erb can be
# accessed by visiting localhost:5000/me
Dir['views/*.html.erb'].each do |file|
  file_name       = file.split('/').last.gsub('.html.erb', '')
  server.mount_proc "/#{file_name}" do |req, res|
    @request        = req
  	content_string  = File.open(file, 'r').read

    # Add the layout in views/layouts/application.html.erb
  	layout_string   = File.open('views/layouts/application.html.erb', 'r').read

  	main_contents   = process_erb(content_string)
  	res.body        = process_erb(layout_string) {main_contents}
  end
end





# ===========
# Catch CTRL+C locally
trap 'INT' do server.shutdown end

# Start the server
server.start