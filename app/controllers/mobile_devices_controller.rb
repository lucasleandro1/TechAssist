class MobileDevicesController < ApplicationController
  before_action :set_mobile_device, only: [:show, :edit, :update, :destroy]

  def index
    @mobile_devices = MobileDevice.includes(:client).all
  end

  def show
  end

  def new
    @mobile_device = MobileDevice.new
    @mobile_device.client_id = params[:client_id] if params[:client_id]
    @clients = Client.all
  end

  def create
    @mobile_device = MobileDevice.new(mobile_device_params)
    
    if @mobile_device.save
      flash[:notice] = 'Dispositivo móvel criado com sucesso.'
      redirect_to @mobile_device
    else
      @clients = Client.all
      render :new
    end
  end

  def edit
    @clients = Client.all
  end

  def update
    if @mobile_device.update(mobile_device_params)
      flash[:notice] = 'Dispositivo móvel atualizado com sucesso.'
      redirect_to @mobile_device
    else
      @clients = Client.all
      render :edit
    end
  end

  def destroy
    @mobile_device.destroy
    redirect_to mobile_devices_url, notice: 'Dispositivo móvel removido com sucesso.'
  end

  def search
    if params[:q_imei_cont].present?
      @mobile_devices = MobileDevice.includes(:client).where("imei LIKE ?", "%#{params[:q_imei_cont]}%")
    else
      @mobile_devices = MobileDevice.includes(:client).all
    end
    render :index
  end

  private

  def set_mobile_device
    @mobile_device = MobileDevice.find(params[:id])
  end

  def mobile_device_params
    params.require(:mobile_device).permit(:client_id, :imei, :serial, :modelo, :marca)
  end
end