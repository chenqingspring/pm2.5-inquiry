module TimeHelper
  def self.time_format(time_string)
    time_info = DateTime.parse(time_string)
    year = time_info.year
    month = time_info.month
    day = time_info.day
    hour = time_info.hour
    min = time_info.min
    "#{year}年#{month}月#{day}日#{hour}时#{min}分"
  end
end