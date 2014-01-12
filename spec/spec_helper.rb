ENV['RACK_ENV'] ||= 'test'
require 'rspec'
require 'yaml'
SETTINGS = YAML.load_file "./config/#{ENV['RACK_ENV']}.yml"
