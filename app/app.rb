require 'sinatra'
require 'wei-backend'
require 'httparty'
require 'uri'
require 'date'

require_relative '../lib/env'
require_relative '../lib/pm25_data'
require_relative '../controller/controller'

on_text do
    url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:Content]}&token=#{SETTINGS['token']}".strip).to_s
    parsed_json = (HTTParty.get(url)).parsed_response

    Pm25Data.new( :name => params[:Content],
                  :city_data => parsed_json
    ).save

    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil?
      return "抱歉！#{parsed_json['error']}，我们会尽快提供！"
    end

    time_format(parsed_json.last['time_point'])
    text_image_message(parsed_json)
end
on_subscribe do
  '欢迎订阅！请发送城市名称(北京)或拼音(beijing)或区号(029)进行查询！'
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

def text_image_message(parsed_json)
  result = []
  result << {
      :title => "查询城市:#{parsed_json.last['area']}",
      :description => "        pm2.5平均值:#{parsed_json.last['pm2_5']}\n污染等级:#{parsed_json.last['quality']}\n发布时间:#{@time}",
      :picture_url => '',
      :url => "#{SETTINGS['production_url']}/zones/#{URI.encode(params[:Content])}"
  }
end
