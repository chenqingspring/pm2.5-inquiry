module Pm25Inquiry
  class GeoCodeHelper
    def self.geo_code_parser lat, lng
      geo_coder_result = location_name lat,lng
      geo_city_name = JSON.parse(geo_coder_result)['result']['addressComponent']['city']
      /(.*)市/.match(geo_city_name)
      if $1.nil?
        geo_city_name
      else
        $1
      end
    end

    def self.location_name lat, lng
      begin
        HttpClient.get(URI.encode("#{SETTINGS['geo_coder_url']}?location=#{lat},#{lng}&coord_type=gcj02&output=json".strip).to_s).parsed_response
      rescue
        return 'error'
      end
    end

  end
end
