# Twitterfeed

Gem that will retrieve and display tweets from a predetermined set of twitter handles. 

## Installation

Add this line to your application's Gemfile:

    gem 'twitterfeed'


## Usage

### Rails 3.1 w/ asset pipeline

Just install and go!

### Rails pre-3.1 or no asset piplie

  rails generate twitterfeed

### In your view

Place helper line anywhere in your project with an array of twitter handles or hashtags:

    <%= twitterfeed(["mark_cap", "wycats", "ruralocity", "#ruby", "#rails"]) %>
    
Options:
    
    <%= twitterfeed(["#ruby", "#rails"], :align => "left", :max => 10, :title => "Cool Ruby Tweets") %>

Enjoy!

Twitter API only allows 150 requests per hour, so to help with this, the frequency on which twitterfeed will update is based on how many handles are passed. I.E. 1 handle will be able to be updated 150 times an hour or every 24 seconds, 10 handles will update every 4 minutes, etc. Maximum of 150 handles. 

## TODO

- Add authentication to boost limit up to 350
- Read a file with twitter handles to initialize
