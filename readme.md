# Minimum Viable Ruby Web Server

## What?

Okay, so this isn't the minimum viable Ruby server, but it is actually useful. Put static files in `/public` and our server will serve them. Put .html.erb files in `/views` directory and our server will add a layout to them and serve them at the same path. So a file in `/views/me.html.erb` will be located at localhost:8000/me.


## Install

LOL, This server uses pure Ruby and standard lib, no install required. Just have vanilla Ruby on your machine.

## Run Locally

Start the Server

    $ ruby server.rb

Visit [localhost:8000](http://localhost:8000)

## It Runs on Heroku

We added a blank Gemfile so Heroku knows to install Ruby on a dyno, then we added a Procfile so Heroku knows how to start our server.

  $ heroku create
  $ git push heroku master
