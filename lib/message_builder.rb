module MessageBuilder
  def self.text_image_message(last_average_data, update_time)
    result = []
    picture_url = select_image
    city_name = last_average_data['area']
    result << {
        :title => "查询城市:#{city_name}",
        :description => "        pm2.5平均值:#{last_average_data['pm2_5']}\n\n污染等级:#{last_average_data['quality']}\n\n发布时间:#{update_time}",
        :picture_url => picture_url,
        :url => URI.encode("#{SETTINGS['app_url']}/zones/#{city_name}")
    }
  end

  private
  def self.select_image
    SETTINGS['image_src'][rand(SETTINGS['image_src'].length)]
  end
end