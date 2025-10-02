class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = current_user.clients.distinct
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    
    if @client.save
      flash[:notice] = 'Cliente criado com sucesso.'
      redirect_to @client
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      flash[:notice] = 'Cliente atualizado com sucesso.'
      redirect_to @client
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    flash[:notice] = 'Cliente removido com sucesso.'
    redirect_to clients_url
  end

  def search
    if params[:q_cpf_cont].present?
      @clients = Client.where("cpf LIKE ?", "%#{params[:q_cpf_cont]}%")
    else
      @clients = Client.all
    end
    render :index
  end

  private

  def set_client
    @client = current_user.clients.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:nome, :cpf, :email, :telefone)
  end
end