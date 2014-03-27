require_relative '../lib/env'

on_text do
    parsed_json = parsed_json_builder params[:Content]
    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil? || parsed_json.length == 0
      return "抱歉！暂未提供该城市pm2.5数据！"
    end
    update_time = TimeHelper.time_format(parsed_json.last['time_point'])
    MessageBuilder.text_image_message(parsed_json.last, update_time)
end

on_location do
  geo_coder_result = HttpClient.get(URI.encode("#{SETTINGS['geo_coder_url']}?location=#{params[:Location_X]},#{params[:Location_Y]}&coord_type=gcj02&output=json".strip).to_s).parsed_response
  geo_city_name = JSON.parse(geo_coder_result)['result']['addressComponent']['city']
  /(.*)市/.match(geo_city_name)
  if $1.nil?
    parsed_json = parsed_json_builder params[:Label]
  else
    parsed_json = parsed_json_builder $1
  end
  if parsed_json.is_a?(Hash) && !parsed_json['error'].nil? || parsed_json.length == 0
    return "抱歉！暂未提供该城市pm2.5数据！"
  end
  update_time = TimeHelper.time_format(parsed_json.last['time_point'])
  MessageBuilder.text_image_message(parsed_json.last, update_time)
end


on_subscribe do
  "欢迎订阅!请发送城市名称(北京)或拼音(beijing)进行查询!"
end

on_unsubscribe do
  '欢迎您再次订阅！'
end

token 'chenqingspring'

def parsed_json_builder city_name
  parsed_json = Pm25ApiHelper.update_city_info(city_name)
  last_city_info = Pm25Data.where(:name => city_name).all.last
  if parsed_json.is_a?(Array) && (last_city_info.nil? || parsed_json.last['time_point'] != last_city_info.city_data.last['time_point'])
    Pm25Data.new( :name => city_name,
                  :city_data => parsed_json
    ).save
  end
  parsed_json
end