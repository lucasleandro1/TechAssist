class AparelhosController < ApplicationController
  def new
    @aparelho = current_user.aparelho.build
  end

  def create
    @aparelho = current_user.aparelho.build(aparelho_params)
    if @aparelho.save
      flash[:notice] = "aparelho created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering aparelho."
      render :new
    end
  end

  def show
    @aparelho = current_user.aparelho.find(params[:id])
    @registro = @aparelho.registro
  end

  def update
    @aparelho = current_user.aparelho.find(params[:id])
    if @aparelho.update(registros_params)
      flash[:notice] = "registros atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "registros não atualizado."
      render :edit
    end
  end


  def edit
    @aparelho = current_user.aparelho.find(params[:id])
  end

  def destroy
    @aparelho = current_user.aparelho.find(params[:id])
    @aparelho.destroy
    redirect_to aparelho_path, notice: 'aparelho excluído com sucesso.'
  end

end