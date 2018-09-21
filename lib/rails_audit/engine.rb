module RailsAudit
  class Engine < ::Rails::Engine

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/rails_audit",
      "#{config.root}/app/models/rails_audit/concerns"
    ]

  end
end
