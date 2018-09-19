$:.push File.expand_path('../lib', __FILE__)
require 'rails_audit/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'rails_audit'
  s.version = RailsAudit::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yougexiangfa/rails_audit'
  s.summary = "Summary of RailsAudit."
  s.description = "Description of RailsAudit."
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0'
end
