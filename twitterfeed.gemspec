# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twitterfeed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Capodagli"]
  gem.email         = ["pimea.mark@gmail.com"]
  gem.description   = %q{Create a nice twitter feed of any specified set of members}
  gem.summary       = %q{Will allow you to see multiple feeds at once.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twitterfeed"
  gem.require_paths = ["lib"]
  gem.version       = Twitterfeed::VERSION
  gem.add_dependency 'twitter', '> 2.2.0'
  
end
