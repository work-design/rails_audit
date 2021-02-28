module Auditor
  class Admin::VerifiersController < Admin::BaseController
    before_action :set_verifier, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @verifiers = Verifier.page(params[:page])
    end

    def new
      @verifier = Verifier.new
    end

    def members
      @verifier = Verifier.new params.permit(:verifiable_type, :verifiable_id)
      @verifier.assign_attributes verifier_params.slice(:job_title_id)

      @members = Member.default_where('member_departments.job_title_id': verifier_params[:job_title_id])
    end

    def create
      @verifier = Verifier.new(verifier_params)

      unless @verifier.save
        render :new, locals: { model: @verifier }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @verifier.assign_attributes(verifier_params)

      unless @verifier.save
        render :edit, locals: { model: @verifier }, status: :unprocessable_entity
      end
    end

    def destroy
      @verifier.destroy
    end

    private
    def prepare_form
      q_params = {}
      q_params.merge! default_params

      @job_titles = Org::JobTitle.default_where(q_params)
    end

    def set_verifier
      @verifier = Verifier.find(params[:id])
    end

    def verifier_params
      p = params.fetch(:verifier, {}).permit(
        :name,
        :job_title_id,
        :member_id
      )
      p.merge! params.permit(:verifiable_type, :verifiable_id)
    end

  end
end
