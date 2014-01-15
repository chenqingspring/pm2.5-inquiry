require './app/app.rb'

use Rack::Reloader

ENV['RACK_ENV'] ||= development

root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :logging, true
set :dump_errors, true

run Sinatra::Application