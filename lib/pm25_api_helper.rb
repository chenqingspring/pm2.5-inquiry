module Pm25ApiHelper
  def self.update_city_info city_name
    HttpClient.get(URI.encode("#{SETTINGS['pm25_query_url']}?city=#{city_name}&token=#{SETTINGS['token']}".strip).to_s).parsed_response
  end

  def self.retrieve_city_ranking_data
    city_ranking_info = city_ranking
    if city_ranking_info.length > 20
      Pm25Data.new(:name => 'city_ranking',
                   :city_ranking => city_ranking_info
      ).save
    end
    Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking].sort! {|x,y| x['pm2_5'].to_i <=> y['pm2_5'].to_i}
  end

  def self.city_ranking
    begin
      HttpClient.get(URI.encode("#{SETTINGS['aqi_ranking_url']}?token=#{SETTINGS['token']}".strip).to_s).parsed_response
    rescue
      return {}
    end
  end

  def self.top10_cities
    cities = retrieve_city_ranking_data
    cities[0..9]
  end

  def self.bottom10_cities
    cities = retrieve_city_ranking_data
    cities[cities.length-10..cities.length-1].reverse
  end

end