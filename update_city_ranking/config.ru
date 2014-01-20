require 'rubygems'
require 'sinatra'
require 'rufus-scheduler'
require 'mongo_mapper'
require 'httparty'
require '../lib/pm25_data'
require '../lib/pm25_api_helper'

SETTINGS = YAML.load_file "../config/#{ENV['RACK_ENV']}.yml"

require File.dirname(__FILE__) + '/update_city_ranking_data'

run Sinatra::Application
