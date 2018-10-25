require 'active_support/configurable'

module RailsAudit #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_class = 'ApplicationController'
    config.my_class = 'MyController'
    config.admin_class = 'AdminController'
    config.current_operator = :current_user
  end

end


