
class Rho::RhoController
  
  def escape(string)
    if string
      string.gsub(/\\\//,'/') 
    else
      p "string is empty....."
      string
    end
  end
  
  def parse_time(time_in_string)
    time_in_string = time_in_string.first if time_in_string.kind_of?(Array)
    day_of_week, month, day, time, timee_zone, year = time_in_string.split
    Time.mktime(year, month, day, time)
  end

  # From http://perezj.blogspot.com/2008/05/ruby-display-datetime-in-words-timeago.html
  def timeago(time, options = {})
    start_date = options.delete(:start_date) || Time.new
    date_format = options.delete(:date_format) || :default
    delta_minutes = (start_date.to_i - time.to_i).floor / 60
    if delta_minutes.abs <= (8724*60)       
      distance = distance_of_time_in_words(delta_minutes)       
      if delta_minutes < 0
         return "#{distance} from now"
      else
         return "#{distance} ago"
      end
    else
       return "on #{DateTime.now.to_formatted_s(date_format)}"
    end
  end
  def distance_of_time_in_words(minutes)
    case
      when minutes < 1
        "less than a minute"
      when minutes == 1
        "about 1 minute"
      when minutes < 50
        "about #{minutes} minutes"
      when minutes < 90
        "about one hour"
      when minutes < 1080
        "#{(minutes / 60).round} hours"
      when minutes < 1440
        "one day"
      when minutes < 2880
        "about one day"
      else
        "#{(minutes / 1440).round} days"
    end
  end
end