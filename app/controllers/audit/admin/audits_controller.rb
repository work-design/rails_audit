class RailsAuditAdmin::AuditsController < RailsAuditAdmin::BaseController

  def index
    @audits = Audit.where(auditable_type: params[:auditable_type], auditable_id: params[:auditable_id]).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

end
