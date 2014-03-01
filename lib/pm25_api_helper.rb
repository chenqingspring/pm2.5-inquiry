module Pm25ApiHelper
  def self.update_city_info city_name
    begin
      HttpClient.get(URI.encode("#{SETTINGS['pm25_query_url']}?city=#{city_name}&token=#{SETTINGS['token']}".strip).to_s).parsed_response
    rescue
      return {}
    end
  end

  def self.retrieve_city_ranking_data
    latest_city_ranking_date = Pm25Data.where(:name => 'city_ranking').all.last

    if latest_city_ranking_date.nil?
      city_ranking_info = city_ranking
      if city_ranking_info.length > 20
        Pm25Data.new(:name => 'city_ranking',
                     :city_ranking => city_ranking_info
        ).save
        return city_ranking_info.to_a.sort! {|x,y| x['pm2_5'].to_i <=> y['pm2_5'].to_i}
      end
    end

    latest_city_ranking = latest_city_ranking_date[:city_ranking]
    latest_time_info = DateTime.parse(latest_city_ranking.first['time_point'])
    current_time = DateTime.current
    if  update_city_ranking_data?(current_time, latest_time_info)
      city_ranking_info = city_ranking
      if city_ranking_info.length > 20
        Pm25Data.new(:name => 'city_ranking',
                     :city_ranking => city_ranking_info
        ).save
        return city_ranking_info.to_a.sort! {|x,y| x['pm2_5'].to_i <=> y['pm2_5'].to_i}
      end
    end
    latest_city_ranking.sort! {|x,y| x['pm2_5'].to_i <=> y['pm2_5'].to_i}
  end

  def self.update_city_ranking_data?(current_time, latest_time_info)
      current_time.year - latest_time_info.year > 0 ||
      current_time.day - latest_time_info.day > 0 ||
      current_time.hour - latest_time_info.hour > 1
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