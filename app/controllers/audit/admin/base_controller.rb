class Audit::Admin::BaseController < RailsAudit.config.app_class.constantize
  default_form_builder 'RailsAuditFormBuilder'


end
