module Twitterfeed
  module ViewHelpers
    def twitterfeed(user)
      Twitter.user_timeline(user).each do |tweet|
        content_tag :pre, tweet.text
      end
    end
  end
end
