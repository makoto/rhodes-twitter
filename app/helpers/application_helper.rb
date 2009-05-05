module ApplicationHelper
  def strip_braces(str=nil)
    str ? str.gsub(/\{/,"").gsub(/\}/,"") : nil
  end
  
  def strike_if(str, condition=true)
    condition ? "<s>#{str}</s>" : str
  end
  
  def display_blanks(value)
    if blank?(value)
      "---"
    else
      value
    end
  end
  
  def blank?(value)
    value.nil? || value == "" || value.length==0
  end
  
  def display_blankstr(value)
    if blank?(value)
      " "
    else
      value
    end
  end
  
  def display_newline()
    "<br>"
  end
  
  def display_space()
    " "
  end
  
  def display_dollars(value)
    if blank?(value)
      " "
    else
      number = "$" + sprintf("%.2f", value)
      
      # use a commify algorithm -- http://snippets.dzone.com/tag/commify
      number.reverse!
      number.gsub!(/(\d\d\d)(?=\d)(?!\d*\.)/, '\1,')
      number.reverse!   
    end   
  end
  
  def display_number(value)
    if blank?(value)
      " "
    else
      sprintf("%.2f", value)
    end   
  end
  
  def both_items_present?(value1, value2)
    !blank?(value1) && !blank?(value2)
  end
  
  def replace_newlines(value)
    if blank?(value)
      " "
    else
      value.gsub('\n', ' ')
    end       
  end
  
  def format_address_for_mapping(street, city, state, zip, tagforurl)
    # handle case where fields could be nil
    mystreet = !street.nil? ? street : ""
    mycity = !city.nil? ? city : ""
    mystate = !state.nil? ? state : ""
    myzip = !zip.nil? ? zip : ""
    
    result = ""
    if !tagforurl
      # build up address string
      result += (mystreet + ", ") if mystreet.length > 0
      result += (mycity + ", ") if mycity.length > 0
      result += (mystate + " ") if mystate.length > 0
      result += myzip if myzip.length > 0
    else
      # need to URL encode data too
      result += ("&street=" + Rho::RhoSupport.url_encode(mystreet)) if mystreet.length > 0
      result += ("&city=" + Rho::RhoSupport.url_encode(mycity)) if mycity.length > 0
      result += ("&state=" + Rho::RhoSupport.url_encode(mystate)) if mystate.length > 0
      result += ("&zip=" + Rho::RhoSupport.url_encode(myzip)) if myzip.length > 0
    end
    # remove any extraneous characters that could interfere with proper address matching
    result = replace_newlines(result)
  end
  
  def has_valid_mapping_address(street, city, state, zip)
    # at a minimum, an address must have a state or a zip
    (!state.nil? && state.length > 0) || (!zip.nil? && zip.length > 0)
  end
  
  def format_latlon_for_mapping(latitude, longitude)
    result = ""
    result += ("&latitude=" + Rho::RhoSupport.url_encode(latitude)) if latitude.length > 0
    result += ("&longitude=" + Rho::RhoSupport.url_encode(longitude)) if longitude.length > 0
    result
  end
  
  def escape(string)
    string.gsub(/\\\//,'/').gsub(/&lt;/,'<').gsub(/&gt;/,'>') if string
  end

  def parse_time(time_in_string)
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
  
  AUTO_LINK_RE = %r{
                  (                          # leading text
                    <\w+.*?>|                # leading HTML tag, or
                    [^=!:'"/]|               # leading punctuation, or
                    ^                        # beginning of line
                  )
                  (
                    (?:https?://)|           # protocol spec, or
                    (?:www\.)                # www.*
                  )
                  (
                    [-\w]+                   # subdomain or domain
                    (?:\.[-\w]+)*            # remaining subdomains or domain
                    (?::\d+)?                # port
                    (?:/(?:[~\w\+@%=\(\)-]|(?:[,.;:'][^\s$]))*)* # path
                    (?:\?[\w\+@%&=.;:-]+)?     # query string
                    (?:\#[\w\-]*)?           # trailing anchor
                  )
                  ([[:punct:]]|<|$|)       # trailing text
                 }x unless const_defined?(:AUTO_LINK_RE)

  # Turns all urls into clickable links.  If a block is given, each url
  # is yielded and the result is used as the link text.
  def auto_link_urls(text, html_options = {})
    # extra_options = tag_options(html_options.stringify_keys) || ""
    text.gsub(AUTO_LINK_RE) do
      all, a, b, c, d = $&, $1, $2, $3, $4
      if a =~ /<a\s/i # don't replace URL's that are already linked
        all
      else
        text = b + c
        text = yield(text) if block_given?
        %(#{a}<a href="#{b=="www."?"http://www.":b}#{c}">#{text}</a>#{d})
      end
    end
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