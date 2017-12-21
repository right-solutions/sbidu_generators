$:.push File.expand_path("../lib", __FILE__)

require "sbidu_generators/version"

Gem::Specification.new do |s|
  s.name        = "sbidu_generators"
  s.version     = SbiduGenerators::VERSION
  s.authors     = ["Krishna Prasad Varma"]
  s.email       = ["krishna@rightsolutions.ae"]
  s.homepage    = "https://github.com/right-solutions/sbidu_generators"
  s.summary     = "Sbidu is a starter kit which generates basic rails elements for a typical sbidu apps"
  s.description = "Sbidu generators rails engine with useful helpers and bootstrap based UI modules"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency 'pry', "~> 0.11.3", ">= 0.11.0"
  s.add_development_dependency 'mysql2', "~> 0.4.4"
  
  s.add_development_dependency 'rspec-rails', "~> 3.5"
  s.add_development_dependency 'capybara', "~> 2.4.4", ">= 2.4.3"
  s.add_development_dependency 'factory_bot_rails', "~> 4.8.0", ">= 4.4.0"
  s.add_development_dependency 'database_cleaner', "~> 1.6.0", ">= 1.4.1"
  s.add_development_dependency 'shoulda-matchers', "~> 3.1"
end
