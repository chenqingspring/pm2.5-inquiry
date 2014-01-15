get '/top10' do

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