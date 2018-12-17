$:.push File.expand_path('lib', __dir__)
require 'rails_audit/version'

Gem::Specification.new do |s|
  s.name = 'rails_audit'
  s.version = RailsAudit::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_audit'
  s.summary = 'Audit changes for model with operator'
  s.description = 'Description of RailsAudit.'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0', '<= 6.0'
  s.add_dependency 'rails_com', '~> 1.2'
end
