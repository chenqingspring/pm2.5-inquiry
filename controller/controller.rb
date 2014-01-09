get '/zones/:city' do
  url = URI.encode("#{SETTINGS['pm25_query_url']}?city=#{params[:city]}&token=#{SETTINGS['token']}".strip).to_s
  parsed_json = (HTTParty.get(url)).parsed_response

  parsed_json.delete(parsed_json.last)

  title = "#{parsed_json.last['area']}各地区pm2.5指数如下:"
  results=[]
  parsed_json.each do |zone|
    results << {
        :position_name => zone['position_name'],
        :pm2_5 => zone['pm2_5'],
        :quality => zone['quality']
    } unless zone['pm2_5'].to_int == 0
  end

  results.sort! {|x,y| y[:pm2_5].to_i <=> x[:pm2_5].to_i }

  haml :zones, :locals => { :zones =>results, :title =>title }
end