require 'yaml'
SETTINGS = YAML.load_file "../config/#{ENV['RACK_ENV']}.yml"

require File.dirname(__FILE__) + '/update_city_ranking_data'