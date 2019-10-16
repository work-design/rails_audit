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

    if @check_setting.save
      redirect_to admin_check_settings_url, notice: 'Check setting was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @check_setting.update(check_setting_params)
      redirect_to admin_check_settings_url, notice: 'Check setting was successfully updated.'
    else
      render :edit
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
