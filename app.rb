require 'sinatra'
require 'wei-backend'
require 'httparty'

require_relative  'env.rb'

on_text do
    parsed_json = (HTTParty.get("#{SETTINGS['pm25_query_url']}?city=#{params[:Content]}&token=#{SETTINGS['token']}")).parsed_response
    result = []
      result << {
         :title => "查询城市:#{parsed_json.last['area']}",
         :description => "pm2.5平均值:#{parsed_json.last['pm2_5']}\n污染等级:#{parsed_json.last['quality']}\n发布时间:#{parsed_json.last['time_point']}"
      }
end
on_subscribe do
  '欢迎订阅！请发送查询城市(拼音)或区号，例如:北京(beijing)或010。功能继续完善ing...!'
end

on_unsubscribe do
  '欢迎您再次订阅！'
end