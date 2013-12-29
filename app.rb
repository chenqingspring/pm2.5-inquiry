require 'sinatra'
require 'wei-backend'
require 'httparty'

require_relative  'env.rb'

on_text do
    parsed_json = (HTTParty.get("#{SETTINGS[:pm25_query_url]}?city=#{params[:Content]}&token=#{SETTINGS[:token]}")).parsed_response
    result = []
    parsed_json.each do |item|
      result << {
          :title => "#{item['position_name']} #{item['pm2_5']} #{item['quality']}"
          #:description => "#{item['pm2_5']}#{item['quality']}"
      }
    end

    return result[0..9] if result.length > 10
    result
end

on_subscribe do
    "感谢您的订阅！请发送城市名称(拼音)或区号进行查询，例如:北京(beijing)或010"
end

on_unsubscribe do
    "欢迎您再次订阅！"
end