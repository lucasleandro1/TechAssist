class MobileDevicesController < ApplicationController
  def index
    @user = current_user
    @mobile_device = @user.mobile_devices
  end

  def new
    @mobile_device = MobileDevice.new
  end

  def create
    @mobile_device = mobile_device.new(mobile_devices_params)
    if @mobile_device.save
      flash[:notice] = "mobile_device created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering mobile_device."
      render :new
    end
  end


  private

  def mobile_devices_params
    params.require(:mobile_devices).permit(:imei,:serial,:modelo,:marca).merge({ user_id: current_user.id })
  end
end