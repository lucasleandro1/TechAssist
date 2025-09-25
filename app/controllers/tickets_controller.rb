class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.includes(mobile_device: :client).all
  end

  def show
  end

  def new
    @ticket = Ticket.new
    @ticket.mobile_device_id = params[:mobile_device_id] if params[:mobile_device_id]
    @ticket.data_abertura = Date.current
    @mobile_devices = MobileDevice.includes(:client).all
  end

  def create
    @ticket = Ticket.new(ticket_params.merge(user_id: current_user&.id || 1))
    
    if @ticket.save
      flash[:notice] = 'Ticket criado com sucesso.'
      redirect_to @ticket
    else
      @mobile_devices = MobileDevice.includes(:client).all
      render :new
    end
  end

  def edit
    @mobile_devices = MobileDevice.includes(:client).all
  end

  def update
    if @ticket.update(ticket_params)
      @ticket.close_ticket if @ticket.status == "Pedido entregue" || @ticket.status == "Pedido reprovado entregue"
      flash[:notice] = 'Ticket atualizado com sucesso.'
      redirect_to @ticket
    else
      @mobile_devices = MobileDevice.includes(:client).all
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket removido com sucesso.'
  end

  def status
    @status = params[:status]
    @tickets = Ticket.where(status: @status).includes(mobile_device: :client)
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                   :comentario, :sintoma, :repair_price,
                                   :mobile_device_id, arquivos: [], pecas: [])
  end
end