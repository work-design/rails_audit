class Audit::Admin::AuditsController < Audit::Admin::BaseController

  def index
    @audits = Audit.where(audited_type: params[:audited_type], audited_id: params[:audited_id]).page(params[:page])
  end

end
