require 'sinatra'
require 'wei-backend'
require 'httparty'

require_relative  'env.rb'

on_text do
    parsed_json = (HTTParty.get("#{SETTINGS['pm25_query_url']}?city=#{params[:Content]}&token=#{SETTINGS['token']}")).parsed_response
    result = []
      result << {
         :title => "#{parsed_json.last['area']}在#{parsed_json.last['time_point']}时刻的pm2.5平均值为:#{parsed_json.last['pm2_5']} 污染等级为:#{parsed_json.last['quality']}"
      }
end
on_subscribe do
  '欢迎订阅！请发送查询城市(拼音)或区号，例如:北京(beijing)或010。功能继续完善ing...!'
end

on_unsubscribe do
  '欢迎您再次订阅！'
end