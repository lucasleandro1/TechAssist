class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    
    if @client.save
      redirect_to @client, notice: 'Cliente criado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Cliente atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Cliente removido com sucesso.'
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
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:nome, :cpf, :email, :telefone)
  end
end