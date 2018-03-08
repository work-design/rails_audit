$:.push File.expand_path('../lib', __FILE__)
require 'the_audit/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'the_audit'
  s.version = TheAudit::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yigexiangfa/the_audit'
  s.summary = "Summary of TheAudit."
  s.description = "Description of TheAudit."
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0'
end
