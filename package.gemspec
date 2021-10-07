Gem::Specification.new do |s|
  s.name = 'rails_audit'
  s.version = '1.0.4'
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_audit'
  s.summary = 'Audit changes for model with operator'
  s.description = 'Description of RailsAudit.'
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails_com', '~> 1.2'
end
