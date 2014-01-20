get '/top10' do
  city_ranking = Pm25ApiHelper.retrieve_city_ranking_data
  results=[]
  city_ranking[0..9].each do |city|
    results << {
        :area => city['area'],
        :pm2_5 => city['pm2_5'],
        :quality => city['quality']
    } unless city['pm2_5'].to_int == 0 || city['aqi'].to_int == 0
  end

  results.sort! {|x,y| x[:pm2_5].to_i <=> y[:pm2_5].to_i }

  update_time = TimeHelper.time_format(city_ranking.first['time_point'])

  haml :top, :locals => { :cities =>results, :time => update_time}
end

get '/bottom10' do
  city_ranking = Pm25ApiHelper.retrieve_city_ranking_data
  results=[]
  city_ranking[city_ranking.length-11..city_ranking.length-1].each do |city|
    results << {
        :area => city['area'],
        :pm2_5 => city['pm2_5'],
        :quality => city['quality']
    } unless city['pm2_5'].to_int == 0 || city['aqi'].to_int == 0
  end

  results.sort! {|x,y| y[:pm2_5].to_i <=> x[:pm2_5].to_i }

  update_time = TimeHelper.time_format(city_ranking.first['time_point'])

  haml :bottom, :locals => { :cities =>results, :time => update_time }
end