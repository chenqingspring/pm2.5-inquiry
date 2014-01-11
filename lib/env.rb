require 'yaml'
require "mongo_mapper"

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "pm25-inquiry"

SETTINGS = YAML.load_file './config/config.yml'