module Auditor
  class Panel::AuditsController < Panel::BaseController
    before_action :set_audit, only: [:show, :edit, :update, :actions, :restore]

    def index
      q_params = {}
      q_params.merge! params.permit(:audited_type, :audited_id)
      @audits = Audit.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def restore
      @audit.restore
    end

    private
    def set_audit
      @audit = Audit.find params[:id]
    end

  end
end
