require 'active_support/configurable'

module RailsAudit #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_class = 'ApplicationController'
    config.my_class = 'My::BaseController'
    config.admin_class = 'Admin::BaseController'
    config.api_class = 'Api::BaseController'
  end

end


