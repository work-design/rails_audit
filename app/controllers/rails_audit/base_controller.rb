class RailsAudit::BaseController < RailsAudit.config.app_class.constantize
  default_form_builder 'RailsAuditFormBuilder'


end
