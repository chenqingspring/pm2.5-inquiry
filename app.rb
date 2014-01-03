require 'sinatra'
require 'wei-backend'
require 'httparty'
require 'uri'
require 'date'

require_relative 'env.rb'
require_relative 'controller'

on_text do
    url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:Content]}&token=#{SETTINGS['token']}".strip).to_s
    parsed_json = (HTTParty.get(url)).parsed_response

    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil?
      return '请发送查询城市(拼音)或区号，例如:北京(beijing)或010'
    end

    time_format(parsed_json.last['time_point'])

    result = []
      result << {
         :title => "查询城市:#{parsed_json.last['area']}",
         :description => "        pm2.5平均值:#{parsed_json.last['pm2_5_24h']}\n污染等级:#{parsed_json.last['quality']}\n发布时间:#{@time}",
         :url => "#{SETTINGS['production_url']}/zones/#{params[:Content]}"
      }
end
on_subscribe do
  '欢迎订阅！请发送查询城市(拼音)或区号，例如:北京(beijing)或010。功能继续完善ing...!'
end

on_unsubscribe do
  '欢迎您再次订阅！'
end


def time_format(time_string)
  time_info = DateTime.parse(time_string)
  year = time_info.year
  month = time_info.month
  day = time_info.day
  hour = time_info.hour
  min = time_info.min
  @time = "#{year}年#{month}月#{day}日#{hour}时#{min}分"
end
