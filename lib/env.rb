require 'uri'
require 'yaml'
require 'date'
require 'haml'
require 'sinatra'
require 'httparty'
require 'wei-backend'
require "mongo_mapper"
require 'rufus-scheduler'
require_relative 'pm25_data'
require_relative 'time_helper'
require_relative 'message_builder'
require_relative 'pm25_api_helper'
require_relative '../controller/zones_controller'
require_relative '../controller/sort_by_city_controller'


MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "pm25-inquiry"

SETTINGS = YAML.load_file "./config/#{ENV['RACK_ENV']}.yml"

SCHEDULER = Rufus::Scheduler.new

SCHEDULER.every '20s' do
  city_ranking_info = Pm25ApiHelper.city_ranking
  if city_ranking_info.length > 20
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end
end

SCHEDULER.join