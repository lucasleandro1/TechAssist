class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @tickets = @user.tickets
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(tickets_params)
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
    @client = @ticket.client
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


  def edit
    @ticket = Ticket.find(params[:id])
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to ticket_path, notice: 'ticket excluído com sucesso.'
  end

  private

  def tickets_params
    params.require(:tickets).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                    :comentario, :sintoma, :anexo, :pecas,
                                    :mobile_device_id).merge({ user_id: current_user.id })
  end
end