class Audit::Admin::BaseController < RailsAudit.config.admin_class.constantize

  def current_operator
    @current_operator ||= send(RailsAudit.config.current_operator)
  end

end
