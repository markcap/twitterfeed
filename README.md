# Twitterfeed

Gem that will retrieve and display tweets from a predetermined set of twitter handles. 

## Installation

Add this line to your application's Gemfile:

    gem 'twitterfeed'

### Rails 3.x with asset pipeline enabled:

Just install and you're good to go!

### Rails without pipeline asset

    rails g twitterfeed
  
## Usage

Place helper line anywhere in your project with an array of twitter handles:

    <%= twitterfeed(["mark_cap", "wycats", "ruralocity"]) %>

Enjoy!

Twitter API only allows 150 requests per hour, so to help with this, the frequency on which twitterfeed will update is based on how many handles are passed. I.E. 1 handle will be able to be updated 150 times an hour or every 24 seconds, 10 handles will update every 4 minutes, etc. Maximum of 150 handles. 

## TODO

- Add authentication to boost limit up to 350
- Read a file with twitter handles to initialize
- Ability to include searches

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
