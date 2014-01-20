module Pm25ApiHelper
  def self.update_city_info city_name
    HTTParty.get(URI.encode("#{SETTINGS['pm25_query_url']}?city=#{city_name}&token=#{SETTINGS['token']}".strip).to_s).parsed_response
  end


  def self.retrieve_city_ranking_data
    city_ranking_info = city_ranking
    city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
    if city_ranking_info.length > 20 && city_ranking_info.first['time_point'] != city_ranking.first['time_point']
      Pm25Data.new(:name => 'city_ranking',
                   :city_ranking => city_ranking_info
      ).save
    end

    Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
  end

  private
  def self.city_ranking
    HTTParty.get(URI.encode("#{SETTINGS['aqi_ranking_url']}?token=#{SETTINGS['token']}".strip).to_s).parsed_response
  end

end