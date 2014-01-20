get '/top10' do

  city_ranking_info = Pm25ApiHelper.city_ranking
  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
  if city_ranking_info.length > 20 && city_ranking_info.first['time_point'] != city_ranking.first['time_point']
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end

  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]

  results=[]
  city_ranking[0..9].each do |city|
    results << {
        :aqi => city[:aqi],
        :area => city['area'],
        :pm2_5 => city['pm2_5'],
        :quality => city['quality']
    } unless city['pm2_5'].to_int == 0 || city['aqi'].to_int == 0
  end

  results.sort! {|x,y| x[:pm2_5].to_i <=> y[:pm2_5].to_i }

  haml :top, :locals => { :cities =>results }
end

get '/bottom10' do

  city_ranking_info = Pm25ApiHelper.city_ranking
  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
  if city_ranking_info.length > 20 && city_ranking_info.first['time_point'] != city_ranking.first['time_point']
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end

  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]

  results=[]
  city_ranking[city_ranking.length-11..city_ranking.length-1].each do |city|
    results << {
        :aqi => city[:aqi],
        :area => city['area'],
        :pm2_5 => city['pm2_5'],
        :quality => city['quality']
    } unless city['pm2_5'].to_int == 0 || city['aqi'].to_int == 0
  end

  results.sort! {|x,y| y[:pm2_5].to_i <=> x[:pm2_5].to_i }

  haml :bottom, :locals => { :cities =>results }
end