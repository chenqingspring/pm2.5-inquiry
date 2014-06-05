require_relative '../lib/env'

on_text do
    parsed_json = Pm25ApiHelper.parsed_json_builder params[:Content].strip
    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil? || parsed_json.length == 0
      return '抱歉！暂未提供该城市pm2.5数据！请发送城市名称(北京)或(beijing)或通过分享地理位置进行查询!'
    end
    update_time = TimeHelper.time_format(parsed_json.last['time_point'])
    MessageBuilder.text_image_message(parsed_json.last, update_time)
end

on_location do
  city_name = Pm25Inquiry::GeoCodeHelper.geo_code_parser params[:Location_X],params[:Location_Y]
  parsed_json = Pm25ApiHelper.parsed_json_builder city_name

  if parsed_json.is_a?(Hash) && !parsed_json['error'].nil? || parsed_json.length == 0
    return '抱歉！暂未提供该城市pm2.5数据！请发送城市名称(北京)或(beijing)或通过分享地理位置进行查询!'
  end
  update_time = TimeHelper.time_format(parsed_json.last['time_point'])
  MessageBuilder.text_image_message(parsed_json.last, update_time)
end


on_subscribe do
  '欢迎订阅!请发送城市名称(北京)或(beijing)或通过分享地理位置进行查询!'
end

on_unsubscribe do
  '欢迎您再次订阅！'
end

token 'chenqingspring'