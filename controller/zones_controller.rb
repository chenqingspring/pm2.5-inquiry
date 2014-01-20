get '/zones/:city' do
  city_info = Pm25Data.where(:name => params[:city]).all.last
  city_data = (city_info.nil? ? Pm25ApiHelper.update_city_info(params[:city]) : city_info.city_data)
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