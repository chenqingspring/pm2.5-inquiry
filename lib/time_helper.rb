module TimeHelper
  def self.time_format(time_string)
    time_info = DateTime.parse(time_string)
    time_info.strftime("%Y-%m-%d %H:%M")
  end
end