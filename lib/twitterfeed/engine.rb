require 'twitterfeed/view_helpers'

module Twitterfeed 
  class Engine < ::Rails::Engine
    initializer "application_controller.initialize_twitterfeed" do
      ActiveSupport.on_load(:action_controller) do
        include Twitterfeed
      end
    
      ActionView::Base.send :include, ViewHelpers
    end
  
  end
end