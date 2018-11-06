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

    respond_to do |format|
      if @check.save
        format.js
        format.html { redirect_to checks_url, notice: 'Check was successfully created.' }
      else
        format.js
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @check.update(check_params)
      redirect_to checks_url, notice: 'Check was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @check.destroy
    redirect_to checks_url, notice: 'Check was successfully destroyed.'
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
    q.merge! operator_type: current_operator.class.name, operator_id: current_operator.id
    q
  end

end
