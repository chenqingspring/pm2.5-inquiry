require './app'

ENV['RACK_ENV'] ||= development

root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir

run Sinatra::Application