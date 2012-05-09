require 'twitter'

module Twitterfeed
  module ViewHelpers
    def twitterfeed(name_array)
      
      twitterfeed_data = YAML.load(File.open("twitterfeed.yml", 'w+'))
      
      #initializing cron type system. This will determine how often data is retrieved from twitter to not go over
      #Twitter API's 150 request per hour limit. The frequency is determined from how many twitter handles are being
      #retrieved. 1 handle will be retrieved maximum of 150 times per hour etc.
      
      if !twitterfeed_data || twitterfeed_data.first["last_update"] < (Time.now - (60.0 * (60.0/(150.0/name_array.size))))
        Twitterfeed.update_twitterfeed(twitterfeed_data, name_array)
      end  
      
      twitterfeed_data = YAML.load(File.open("twitterfeed.yml"))
      #removing update time from array
      twitterfeed_data.slice!(0)
      render :partial => "twitterfeed/twitterfeed_box", :locals => { :tweet_array =>  twitterfeed_data}
 
    end
    
    def tweet_time(time)
      #displays the time for a tweet i.e. 36m, 12h, May 5
      if time < (Time.now - (3600 * 24))
        time.strftime("%b %-d")
      else
        time_ago = Time.now - time
        if time_ago < 3600
          "#{(time_ago / 60).to_i}m"
        else 
          "#{(time_ago / 3600).to_i}h"
        end
      end
    end
  end
end

