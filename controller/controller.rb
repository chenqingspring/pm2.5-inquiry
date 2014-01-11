get '/zones/:city' do
  city_data = Pm25Data.where(:name => params[:city]).all.last.city_data

  if city_data.nil?
    url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:city]}&token=#{SETTINGS['token']}".strip).to_s
    city_data = (HTTParty.get(url)).parsed_response
  end

  city_data.delete(city_data.last)

  title = "#{city_data.last['area']}各地区pm2.5指数如下:"
  results=[]
  city_data.each do |zone|
    results << {
        :position_name => zone['position_name'],
        :pm2_5 => zone['pm2_5'],
        :quality => zone['quality']
    } unless zone['pm2_5'].to_int == 0
  end

  results.sort! {|x,y| y[:pm2_5].to_i <=> x[:pm2_5].to_i }

  haml :zones, :locals => { :zones =>results, :title =>title }
end