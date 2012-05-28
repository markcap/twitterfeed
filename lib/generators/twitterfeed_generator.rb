class TwitterfeedGenerator < Rails::Generators::Base
  source_root File.expand_path("../../templates", __FILE__)
  
  def create_initializer_file
    copy_file "../../app/assets/stylesheets/twitterfeed.css", "public/stylesheets/twitterfeed.css"
  end
end