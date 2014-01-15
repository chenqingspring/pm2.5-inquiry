module TimeHelper
  def self.time_format(time_string)
    time_info = DateTime.parse(time_string)
    year = time_info.year
    month = time_info.month.to_int >= 10 ? time_info.month : "0#{time_info.month}"
    day = time_info.month.to_int >= 10 ? time_info.month : "0#{time_info.month}"
    hour = time_info.month.to_int >= 10 ? time_info.month : "0#{time_info.month}"
    min = time_info.month.to_int >= 10 ? time_info.month : "0#{time_info.month}"
    "#{year}-#{month}-#{day} #{hour}:#{min}"
  end
end