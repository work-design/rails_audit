$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_history/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_history"
  s.version     = TheHistory::VERSION
  s.authors     = ["qinmingyuan"]
  s.email       = ["mingyuan0715@foxmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TheHistory."
  s.description = "TODO: Description of TheHistory."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
