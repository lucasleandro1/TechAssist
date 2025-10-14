class MobileDevicesController < ApplicationController
  before_action :set_mobile_device, only: [:show, :edit, :update, :destroy]

  def index
    @mobile_devices = current_user.mobile_devices.includes(:client).distinct
  end

  def show
  end

  def new
    @mobile_device = MobileDevice.new
    @mobile_device.client_id = params[:client_id] if params[:client_id]
    @clients = current_user.clients
  end

  def select_or_create
    @client = current_user.clients.find(params[:client_id])
    @existing_devices = @client.mobile_devices
    @mobile_device = MobileDevice.new(client_id: @client.id)
  end

  def use_existing
    mobile_device = current_user.mobile_devices.find(params[:mobile_device_id])
    flash[:notice] = 'Dispositivo selecionado com sucesso.'
    redirect_to new_ticket_path(mobile_device_id: mobile_device.id)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Dispositivo não encontrado ou não pertence a você.'
    redirect_to mobile_devices_path
  end

  def create
    @mobile_device = MobileDevice.new(mobile_device_params)
    
    if @mobile_device.save
      flash[:notice] = 'Dispositivo móvel criado com sucesso.'
      # Redireciona para criar ticket
      redirect_to new_ticket_path(mobile_device_id: @mobile_device.id)
    else
      @clients = current_user.clients
      render :new
    end
  end

  def edit
    @clients = current_user.clients
  end

  def update
    if @mobile_device.update(mobile_device_params)
      flash[:notice] = 'Dispositivo móvel atualizado com sucesso.'
      redirect_to @mobile_device
    else
      @clients = current_user.clients
      render :edit
    end
  end

  def destroy
    @mobile_device.destroy
    redirect_to mobile_devices_url, notice: 'Dispositivo móvel removido com sucesso.'
  end

  def search
    if params[:q_imei_cont].present?
      @mobile_devices = current_user.mobile_devices.includes(:client).where("imei LIKE ?", "%#{params[:q_imei_cont]}%")
    else
      @mobile_devices = current_user.mobile_devices.includes(:client).distinct
    end
    render :index
  end

  private

  def set_mobile_device
    @mobile_device = current_user.mobile_devices.find(params[:id])
  end

  def mobile_device_params
    params.require(:mobile_device).permit(:client_id, :imei, :serial, :modelo, :marca)
  end
end