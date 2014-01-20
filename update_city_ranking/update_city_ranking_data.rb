require 'rubygems'
require 'sinatra'
require 'rufus-scheduler'
require 'mongo_mapper'
require 'httparty'
require '../lib/pm25_data'
require '../lib/pm25_api_helper'

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "pm25-inquiry"

scheduler = Rufus::Scheduler.new

scheduler.every '300s', :first_in => 0 do
  city_ranking_info = Pm25ApiHelper.city_ranking
  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
  if city_ranking_info.length > 20 && city_ranking_info.first['time_point'] != city_ranking.first['time_point']
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end
end