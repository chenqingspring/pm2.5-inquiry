module Pm25ApiHelper
  def self.update_city_info city_name
    HTTParty.get(URI.encode("#{SETTINGS['pm25_query_url']}?city=#{city_name}&token=#{SETTINGS['token']}".strip).to_s).parsed_response
  end
end