module Auditor
  class Panel::AuditsController < Panel::BaseController

    def index
      q_params = {}
      q_params.merge! params.permit(:audited_type, :audited_id)
      @audits = Audit.default_where(q_params).order(id: :desc).page(params[:page])
    end

  end
end
