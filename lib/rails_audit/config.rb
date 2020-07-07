require 'active_support/configurable'

module RailsAudit #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.default_except = [
      'updated_at'
    ]
  end

end


