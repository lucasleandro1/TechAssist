class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.new(parsed_params)
    if @ticket.save
      flash[:notice] = "ticket created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering ticket."
      render :new
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @aparelho = @ticket.mobile_device
  end

  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params)
      flash[:notice] = "ticket atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "ticket não atualizado."
      render :edit
    end
  end

  def status
    @status = params[:status]
    @tickets = Ticket.where(status: @status)
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to tickets_path, notice: 'ticket excluído com sucesso.'
  end

  private

  def parsed_params
    ticket_params.tap do |hash|
      hash["sintoma"] = ticket_params["sintoma"].to_i
      hash["pecas"] = ticket_params["pecas"].to_i
      hash["status"] = ticket_params["status"].to_i
    end
  end

  def ticket_params
    params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                    :comentario, :sintoma, :anexo, :pecas,
                                    :mobile_device_id)
  end
end