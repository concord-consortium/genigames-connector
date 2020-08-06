$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "genigames_connector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "genigames_connector"
  s.version     = GenigamesConnector::VERSION
  s.authors     = ["Aaron Unger"]
  s.email       = ["aunger@concord.org"]
  s.homepage    = "http://concord.org"
  s.summary     = "An interface between the CC Portal and the CC Genigames runtime and CC Genigames authoring."
  s.description = "Provides processing hooks for converting learner data in the portal into objects for reporting. Also translates the Genigames authored activity structure into a CC Portal activity structure, for reporting purposes."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.2.11"

  # make sure to match gem versions with the portal
  s.add_dependency "haml", "~> 4.0"
  s.add_dependency "json", "~> 1.8.6"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec",       "~> 2.12.0"
  s.add_development_dependency "rspec-rails", "~> 2.12.1"
  s.add_development_dependency "ci_reporter", "~> 1.7.0"
  s.add_development_dependency "fakeweb",     "~> 1.3.0"
end
