class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = current_user.clients
  end

  def show
  end

  def new
    @client = current_user.clients.build
  end

  def create
    @client = current_user.clients.build(client_params)
    
    if @client.save
      flash[:notice] = 'Cliente criado com sucesso.'
      # Redireciona para criar dispositivo móvel ou selecionar existente
      redirect_to select_or_create_mobile_devices_path(@client.id)
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
      @clients = current_user.clients.where("cpf LIKE ?", "%#{params[:q_cpf_cont]}%")
    else
      @clients = current_user.clients
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