%w(bottom10 top10).each do |page|
  get "/sort/#{page}" do
    results=[]
    sorted_cities = eval("Pm25ApiHelper.#{page}_cities")
    sorted_cities.each do |city|
      results << {
          :area => city['area'],
          :pm2_5 => city['pm2_5'],
          :quality => city['quality']
      } unless city['pm2_5'].to_int == 0 || city['aqi'].to_int == 0
    end
    update_time = TimeHelper.time_format(sorted_cities.first['time_point'])

    haml page.to_sym, :locals => { :cities =>results, :time => update_time}
  end

end