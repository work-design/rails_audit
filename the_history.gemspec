$:.push File.expand_path('../lib', __FILE__)
require 'the_history/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'the_history'
  s.version = TheHistory::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yigexiangfa/the_history'
  s.summary = "Summary of TheHistory."
  s.description = "Description of TheHistory."
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0'
end
