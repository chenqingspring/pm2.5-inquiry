require 'sinatra'
require 'wei-backend'
require 'httparty'
require 'uri'
require 'date'

require_relative '../lib/env'
require_relative '../lib/pm25_data'
require_relative '../lib/time_helper'
require_relative '../lib/message_builder'
require_relative '../controller/controller'

on_text do
    url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:Content]}&token=#{SETTINGS['token']}".strip).to_s
    parsed_json = (HTTParty.get(url)).parsed_response

    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil?
      return "抱歉！#{parsed_json['error']}，我们会尽快提供！"
    end

    last_city_info = Pm25Data.where(:name => params[:Content]).all.last

    if last_city_info.nil? || parsed_json.last['time_point'] != last_city_info.city_data.last['time_point']
      Pm25Data.new( :name => params[:Content],
                    :city_data => parsed_json
      ).save
    end

    TimeHelper.time_format(parsed_json.last['time_point'])
    MessageBuilder.text_image_message(parsed_json)
end

on_subscribe do
  "欢迎订阅!请发送城市名称(北京)或拼音(beijing)进行查询!"
end

on_unsubscribe do
  '欢迎您再次订阅！'
end
