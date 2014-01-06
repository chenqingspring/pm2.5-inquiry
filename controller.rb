get '/zones/:city' do
  url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:city]}&token=#{SETTINGS['token']}".strip).to_s
  parsed_json = (HTTParty.get(url)).parsed_response

  parsed_json.delete(parsed_json.last)

  results = ["#{parsed_json.last['area']}各地区pm2.5指数如下:"]
  parsed_json.each do |zone|
    results << "#{zone['position_name']}  #{zone['pm2_5_24h']}  #{zone['quality']}"  unless zone['pm2_5_24h'].to_int == 0
  end
  haml :zones, :locals => { :zones =>results }
end