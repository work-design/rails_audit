class Audit::Admin::ApprovalsController < Audit::Admin::BaseController
  before_action :set_approval, only: [:show, :edit, :update, :destroy]

  def index
    @approvals = Approval.page(params[:page])
  end

  def new
    @approval = Approval.new
  end

  def create
    @approval = Approval.new(approval_params)

    unless @approval.save
      render :new, locals: { model: @approval }, status: :unprocessable_entity
    end
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
