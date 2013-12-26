require 'sinatra'
require 'wei-backend'
require 'httparty'

require_relative  'env.rb'

on_text do
    parsed_json = (HTTParty.get("#{SETTINGS[:pm25_query_url]}?city=#{params[:Content]}&token=#{SETTINGS[:token]}")).parsed_response
    result = []
    parsed_json.map do |item|
      result << {
          :title => item['position_name'],
          :description => "#{item['pm2_5']} #{item['quality']}"
      }
    end
  result
end

on_subscribe do
    "感谢您的订阅"
end

on_unsubscribe do
    "欢迎您再次订阅"
end
