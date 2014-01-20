ENV['RACK_ENV'] ||= 'development'

require 'rufus-scheduler'
require_relative '../lib/env'

scheduler = Rufus::Scheduler.new

scheduler.every '5s', :first_in => 0 do
  city_ranking_info = Pm25ApiHelper.city_ranking
  if city_ranking_info.length > 20
    Pm25Data.new( :name => 'city_ranking',
                  :city_ranking => city_ranking_info
    ).save
  end
end

scheduler.join