module Pm25ApiHelper
  def self.update_city_info city_name
    begin
      HttpClient.post('https://pm25-weapp.leanapp.cn/1.1/functions/searchByLocation',
                      {:body => {'cityName' => city_name }.to_json,
                       :headers => {'X-LC-Id' => 'PmV1nY70lW7jOSgdaz77Ek4x-gzGzoHsz',
                                    'X-LC-Key' => 'y73IcLAkxJznpDxczxmA9sak',
                                    'Content-Type' => 'application/json',
                                    'Accept' => '*/*'}
                      }).parsed_response['result']
    rescue
      return {}
    end
  end

  def self.retrieve_city_ranking_data
      city_ranking_info = city_ranking
      city_ranking_info.to_a.sort! {|x,y| x['pm2_5'].to_i <=> y['pm2_5'].to_i}
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
    ten_cities = cities[cities.length-10..cities.length-1]
    ten_cities.nil? ? [] : ten_cities.reverse
  end

  def self.parsed_json_builder city_name
    update_city_info(city_name)
  end

end