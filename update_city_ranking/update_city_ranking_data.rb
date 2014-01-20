scheduler = Rufus::Scheduler.new

MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "pm25-inquiry"

scheduler.every '10s', :first_in => 0 do
  puts 'test'
  city_ranking_info = Pm25ApiHelper.city_ranking
  city_ranking = Pm25Data.where(:name => 'city_ranking').all.last[:city_ranking]
  if city_ranking_info.length > 20 && city_ranking_info.first['time_point'] != city_ranking.first['time_point']
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end
end