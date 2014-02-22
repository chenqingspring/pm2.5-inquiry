require_relative '../lib/env'

#on_text do
#    parsed_json = Pm25ApiHelper.update_city_info(params[:Content])
#
#    if parsed_json.is_a?(Hash) && !parsed_json['error'].nil?
#      return "抱歉！暂未提供该城市pm2.5数据！"
#    end
#
#    last_city_info = Pm25Data.where(:name => params[:Content]).all.last
#
#    if last_city_info.nil? || parsed_json.last['time_point'] != last_city_info.city_data.last['time_point']
#      Pm25Data.new( :name => params[:Content],
#                    :city_data => parsed_json
#      ).save
#    end
#
#    update_time = TimeHelper.time_format(parsed_json.last['time_point'])
#    MessageBuilder.text_image_message(parsed_json.last, update_time)
#end
#
#on_subscribe do
#  "欢迎订阅!请发送城市名称(北京)或拼音(beijing)进行查询!"
#end
#
#on_unsubscribe do
#  '欢迎您再次订阅！'
#end
#
#token 'chenqingspring'
