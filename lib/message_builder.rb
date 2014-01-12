module MessageBuilder
  def self.text_image_message(parsed_json, update_time)
    result = []
    picture_url = select_image(parsed_json)
    city_name = parsed_json.last['area']
    result << {
        :title => "查询城市:#{city_name}",
        :description => "        pm2.5平均值:#{parsed_json.last['pm2_5']}\n\n污染等级:#{parsed_json.last['quality']}\n\n发布时间:#{update_time}",
        :picture_url => picture_url,
        :url => URI.encode("#{SETTINGS['production_url']}/zones/#{city_name}")
    }
  end

  private
  def self.select_image(parsed_json)
    parsed_json.last['pm2_5'].to_i <= 100 ? SETTINGS['image_src_1'] : SETTINGS['image_src_2']
  end
end