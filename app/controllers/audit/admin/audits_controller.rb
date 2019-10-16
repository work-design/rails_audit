class Audit::Admin::AuditsController < Audit::Admin::BaseController

  def index
    @audits = Audit.where(auditable_type: params[:auditable_type], auditable_id: params[:auditable_id]).page(params[:page])
  end

end
