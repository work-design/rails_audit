module Auditor
  class Admin::VerificationsController < Admin::BaseController
    before_action :set_check, only: [:show, :edit, :update, :destroy]

    def index
      @verifications = Verification.page(params[:page])
    end

    def new
      @verification = Verification.new(state: params[:state])
    end

    def create
      @verification = Verification.new(check_params)

      unless @verification.save
        render :new, locals: { model: @verification }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @verification.assign_attributes(check_params)

      unless @verification.save
        render :edit, locals: { model: @verification }, status: :unprocessable_entity
      end
    end

    def destroy
      @verification.destroy
    end

    private
    def set_verified
      @verified = params[:verified_type].safe_constantize&.find_by(id: params[:verified_id])
    end

    def set_check
      @verification = Verification.find(params[:id])
    end

    def check_params
      q = params.fetch(:verification, {}).permit(
        :comment,
        :confirmed,
        :state
      )
      q.merge! verified_type: params[:verified_type], verified_id: params[:verified_id]
      q.merge! member_id: current_member&.id
      q.merge! user_id: current_user.id
      q
    end

  end
end
