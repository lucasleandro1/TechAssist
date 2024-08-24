class ClientesController < ApplicationController
  def new
    @cliente = current_user.clientes.build
  end

  def create
    @cliente = current_user.cliente.build(cliente_params)
    if @cliente.save
      flash[:notice] = "cliente created."
      redirect_to root_path
    else
      flash[:error] = "Error when registering cliente."
      render :new
    end
  end

  def show
    @cliente = current_user.cliente.find(params[:id])
    @aparelho = @cliente.aparelho
  end

  def update
    @cliente = current_user.cliente.find(params[:id])
    if @cliente.update(registros_params)
      flash[:notice] = "registros atualizado com sucesso."
      redirect_to root_path
    else
      flash[:error] = "registros não atualizado."
      render :edit
    end
  end


  def edit
    @cliente = current_user.cliente.find(params[:id])
  end

  def destroy
    @cliente = current_user.cliente.find(params[:id])
    @cliente.destroy
    redirect_to cliente_path, notice: 'cliente excluído com sucesso.'
  end

end