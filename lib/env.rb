require 'uri'
require 'yaml'
require 'date'
require 'haml'
require 'sinatra'
require 'httparty'
require 'wei-backend'
require "mongo_mapper"
require_relative 'pm25_data'
require_relative 'time_helper'
require_relative 'message_builder'
require_relative 'pm25_api_helper'
require_relative '../controller/controller'


MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "pm25-inquiry"

SETTINGS = YAML.load_file "./config/#{ENV['RACK_ENV']}.yml"