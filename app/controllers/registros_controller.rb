class RegistrosController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @registros = @user.resgistro
  end

  def new
    @registros = current_user.registros.build
  end

  def create
    @registros = current_user.registros.build(registros_params)
    if @registros.save
      flash[:notice] = "registros created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering registros."
      render :new
    end
  end

  def show
    @registros = current_user.registros.find(params[:id])
    @cliente = @registros.cliente
  end

  def update
    @registros = current_user.registros.find(params[:id])
    if @registros.update(registros_params)
      flash[:notice] = "registros atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "registros não atualizado."
      render :edit
    end
  end


  def edit
    @registros = current_user.registros.find(params[:id])
  end

  def destroy
    @registros = current_user.registros.find(params[:id])
    @registros.destroy
    redirect_to registros_path, notice: 'registros excluído com sucesso.'
  end

  private

  # def registros_params
  #   params.require(:registros).permit(:id, :text, :tag, :foto)
  # end
end