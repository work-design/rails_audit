class Audit::Admin::ChecksController < Audit::Admin::BaseController
  before_action :set_check, only: [:show, :edit, :update, :destroy]

  def index
    @checks = Check.page(params[:page])
  end

  def new
    @check = Check.new(state: params[:state])
  end

  def create
    @check = Check.new(check_params)

    if @check.save
      render :new, locals: { model: @check }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @check.assign_attributes(check_params)
    
    if @check.save
      render :edit, locals: { model: @check }, status: :unprocessable_entity
    end
  end

  def destroy
    @check.destroy
  end

  private
  def set_checking
    @checking = params[:checking_type].safe_constantize&.find_by(id: params[:checking_id])
  end

  def set_check
    @check = Check.find(params[:id])
  end

  def check_params
    q = params.fetch(:check, {}).permit(
      :comment,
      :confirmed,
      :state
    )
    q.merge! checking_type: params[:checking_type], checking_id: params[:checking_id]
    q.merge! operator_type: rails_audit_user.class.name, operator_id: rails_audit_user.id
    q
  end

end
