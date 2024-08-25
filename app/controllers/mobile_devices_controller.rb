class MobileDevicesController < ApplicationController
  before_action :authenticate_user!, :set_client

  def new
    @mobile_device = MobileDevice.new
  end

  def create
    @mobile_device = @client.mobile_devices.new(mobile_device_params)
    if @mobile_device.save
      flash[:notice] = "mobile_device created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering mobile_device."
      render :new
    end
  end

  def show
    @mobile_device = MobileDevice.find(params[:id])
    @client = @mobile_device.client
  end

  def update
    @mobile_device = MobileDevice.find(params[:id])
    if @mobile_device.update(mobile_device_params)
      flash[:notice] = "aparelho atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "aparelho não atualizado."
      render :edit
    end
  end


  def edit
    @mobile_device = MobileDevice.find(params[:id])
  end

  def destroy
    @mobile_device = MobileDevice.find(params[:id])
    @mobile_device.destroy
    redirect_to mobile_devices_path, notice: "aparelho excluído com sucesso."
  end

  def search
    if params[:q_imei_cont].present?
      @mobile_devices = MobileDevice.where('imei LIKE ?', "%#{params[:q_imei_cont]}%")
    else
      render new_mobile_device_path

    end
    respond_to do |format|
      format.html { render :search_results }
      format.json { render json: @mobile_devices }
    end
  end

  def home
    @imei = params[:imei] if params[:imei].present?
  end


  private

  def set_client
    @client = Client.last
  end

  def mobile_device_params
    params.require(:mobile_device).permit(:imei,:serial,:modelo,:marca,:client_id)
  end
end