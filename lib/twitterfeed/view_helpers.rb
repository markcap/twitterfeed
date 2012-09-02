require 'twitter'

module Twitterfeed
  module ViewHelpers
    
    def twitterfeed(name_array, options = {})

      defaults = Twitterfeed.set_defaults(options)
      
      twitterfeed_data = YAML.load(File.open("tmp/twitterfeed.yml", 'w+'))
      
      #initializing cron type system. This will determine how often data is retrieved from twitter to not go over
      #Twitter API's 150 request per hour limit. The frequency is determined from how many twitter handles are being
      #retrieved. 1 handle will be retrieved maximum of 150 times per hour etc.
      
      if !twitterfeed_data || twitterfeed_data.first["last_update"] < (Time.now - (60.0 * (60.0/(150.0/name_array.size))))
        Twitterfeed.update_twitterfeed(twitterfeed_data, name_array, defaults[:max])
      end  
      
      twitterfeed_data = YAML.load(File.open("tmp/twitterfeed.yml"))
      #removing update time from array
      twitterfeed_data.slice!(0)
      render :partial => "twitterfeed/twitterfeed_box", 
        :locals => { :tweet_array =>  twitterfeed_data, :align => defaults[:align], :title => defaults[:title]}
 
    end
    
    def tweet_time(time)
      #displays the time for a tweet i.e. 36m, 12h, May 5
      if time < (Time.now - (3600 * 24))
        time.strftime("%b %d")
      else
        time_ago = Time.now - time
        if time_ago < 3600
          "#{(time_ago / 60).to_i}m"
        else 
          "#{(time_ago / 3600).to_i}h"
        end
      end
    end
    
    def linkify_tweet(tweet)
      #this turns all hashtags, ats, and links into html links to click on
      @ats = tweet.scan(/@\w+/)
      @tags = tweet.scan(/#\S+/)
      @links = tweet.scan(/https?:\/\/\S+/)
      
      @ats.each do |a|
        at = sanitize_link(a)
        tweet.gsub!(/#{at}/, "<a href='http://twitter.com/#{at[1..(at.length - 1)]}' target='_blank'>#{at}</a>")
      end
      
      @tags.each do |t|
        tag = sanitize_link(t)
        tweet.gsub!(/#{tag}(\Z|[\s.,()!?\"\'*])/, "<a href='http://twitter.com/search/%23#{tag[1..(tag.length - 1)]}' target='_blank'>#{tag}</a> ")
      end
      
      @links.each do |l|
        link = sanitize_link(l)
        tweet.gsub!(/#{link}/, "<a href='#{link}' target='_blank'>#{link}</a>")
      end
      
      tweet.html_safe
    end
    
    def sanitize_link(item)
      #this enables crap like (#ruby) and "http://yahoo.com" to link properly in tweets
      while item.last =~ /[.,()!?\"\'*]/
        item.chop!
      end
      item
    end
    
  end
end

