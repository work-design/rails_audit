class Audit::Admin::ApprovalsController < Audit::Admin::BaseController
  before_action :set_approval, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:approving_type, :approving_id)
    @approvals = Approval.default_where(q_params).order(id: :desc).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @approval.assign_attributes(approval_params)

    unless @approval.save
      render :edit, locals: { model: @approval }, status: :unprocessable_entity
    end
  end

  def destroy
    @approval.destroy
  end

  private
  def set_approval
    @approval = Approval.find(params[:id])
  end

  def approval_params
    params.fetch(:approval, {}).permit(
      :pending_changes,
      :approved,
      :state
    )
  end

end
