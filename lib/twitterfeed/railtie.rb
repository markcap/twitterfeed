require 'twitterfeed/view_helpers'

module Twitterfeed 
  class Railtie < Rails::Railtie
    initializer "application_controller.initialize_twitterfeed" do
      ActiveSupport.on_load(:action_controller) do
        include Twitterfeed
      end
    
      ActionView::Base.send :include, ViewHelpers
    end
  
  end
end