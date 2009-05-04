
class Rho::RhoController
  
  def escape(string)
    return nil unless string
    string.gsub(/\\\//,'/').gsub(/&lt;/,'<').gsub(/&gt;/,'>') if string
  end
  
  def parse_time(time_in_string)
    return nil unless time_in_string
    time_in_string = time_in_string.first if time_in_string.kind_of?(Array)

    # This is due to annoying inconsistance between Twitter's search API and REST API
    # http://twitter.com/makoto_inoue/status/1457257044
    # rss or atom format returns consistent date format, but REST API rss/atom format
    # does not include profile image url, while search api are.
    if time_in_string.match(',')
      # Search API date format: "time_in_string: Sun, 05 Apr 2009 14:37:34 +0000"
      day_of_week, day, month, year, time, timee_zone = time_in_string.split
    else
      # REST API date format "time_in_string: Sun Apr 05 14:52:39 +0000 2009"
      day_of_week, month, day, time, timee_zone, year = time_in_string.split
    end

    time_object = Time.mktime(year, month, day, time)
    timeago(time_object)
  end

private
  # From http://perezj.blogspot.com/2008/05/ruby-display-datetime-in-words-timeago.html
  def timeago(time, options = {})
    start_date = options.delete(:start_date) || Time.new
    date_format = options.delete(:date_format) || :default
    p " (#{start_date.inspect}.to_i - #{time.inspect}.to_i).floor"
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
      when  minutes < 50
        "about #{minutes} minutes"
      when minutes < 90
        "about one hour"
      when minutes < 1080
        "#{(minutes / 60.0).round} hours"
      when minutes < 1440
        "one day"
      when minutes < 2880
        "about one day"
      else
        "#{(minutes / 1440).round} days"
    end
  end
end