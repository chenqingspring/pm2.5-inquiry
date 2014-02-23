get '/zones/:city' do
  city_data = Pm25ApiHelper.update_city_info(params[:city])

  if city_data.is_a?(Hash) && !city_data['error'].nil?
    return haml :zones, :locals => { :zones =>{}, :title =>"抱歉！暂未提供该城市pm2.5数据！", :time => DateTime.now.strftime("%Y-%m-%d %H:%M")  }
  end

  city_data.delete(city_data.last)

  title = "#{city_data.last['area']}各监测点pm2.5指数如下:"
  results=[]
  city_data.each do |zone|
    results << {
        :position_name => zone['position_name'],
        :pm2_5 => zone['pm2_5'],
        :quality => zone['quality']
    } unless zone['pm2_5'].to_int == 0
  end

  results.sort! {|x,y| y[:pm2_5].to_i <=> x[:pm2_5].to_i }

  update_time = TimeHelper.time_format(city_data.first['time_point'])

  haml :zones, :locals => { :zones =>results, :title =>title, :time => update_time }
end