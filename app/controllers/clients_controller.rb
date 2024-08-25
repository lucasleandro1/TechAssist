class ClientsController < ApplicationController
  before_action :authenticate_user!
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = "client created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering client."
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      flash[:notice] = "cliente atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "cliente não atualizado."
      render :edit
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_path, notice: "cliente excluído com sucesso."
  end

  def search
    if params[:q_cpf_cont].present?
      @clients = Client.where('cpf LIKE ?', "%#{params[:q_cpf_cont]}%")
    else
      render new_client_path

    end
    respond_to do |format|
      format.html { render :search_results }
      format.json { render json: @clients }
    end
  end

  def home
    @cpf = params[:cpf] if params[:cpf].present?
  end

  private

  def client_params
    params.require(:client).permit(:cpf,:nome,:telefone,:email)
  end
end