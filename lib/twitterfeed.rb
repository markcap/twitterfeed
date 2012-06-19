require 'twitter'

module Twitterfeed
  
  require 'twitterfeed/engine' if defined?(Rails)
  
  def self.update_twitterfeed(twitterfeed_data, name_array)
    total_tweets = []
    name_array.first(150).each do |name|
      if name[0] == "#"
        Twitter.search(name, :rpp => 20).each do |tweet|
          total_tweets << tweet 
        end
      else
        Twitter.user_timeline(name, :include_rts => true).each do |tweet|
          total_tweets << tweet 
        end
      end
    end
  
    tweet_array = [{"last_update" => Time.now}]
    total_tweets.sort_by {|x| x.created_at}.reverse.first(20).each do |tweet|
      tweet_array << {
                      #searches and users have different username methods
                      "handle" => tweet.user.nil? ? tweet.from_user : tweet.user.screen_name,
                      "text" => tweet.text, 
                      "created_at" => tweet.created_at,
                      "pic_url" => tweet.user.nil? ? tweet.profile_image_url_https : tweet.user.profile_image_url_https
                      }
    end
    File.open('twitterfeed.yml', 'w') {|f| f.write(tweet_array.to_yaml) }
  end
  
end
