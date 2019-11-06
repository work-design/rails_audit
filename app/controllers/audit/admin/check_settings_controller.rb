class Audit::Admin::CheckSettingsController < Audit::Admin::BaseController
  before_action :set_check_setting, only: [:show, :edit, :update, :destroy]

  def index
    @check_settings = CheckSetting.page(params[:page])
  end

  def new
    @check_setting = CheckSetting.new
  end

  def create
    @check_setting = CheckSetting.new(check_setting_params)

    unless @check_setting.save
      render :new, locals: { model: @check_setting }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @check_setting.assign_attributes(check_setting_params)
    
    if @check_setting.save
      render :edit, locals: { model: @check_setting }, status: :unprocessable_entity
    end
  end

  def destroy
    @check_setting.destroy
  end

  private
  def set_check_setting
    @check_setting = CheckSetting.find(params[:id])
  end

  def check_setting_params
    params.fetch(:check_setting, {}).permit(
      :code
    )
  end

end
