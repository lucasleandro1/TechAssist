module Api
  module V1
    class ClientsController < ApplicationController
      # before_action :authenticate_user!

      def index
        @clients = Client.includes(:mobile_devices).all
        render json: @clients.to_json(include: :mobile_devices)
      end

      def create
        @client = Client.new(client_params)
        if @client.save
          render json: {
            message: "Client created successfully.",
            client: @client
          }, status: :created
        else
          render json: {
            message: "Error when registering client.",
            errors: @client.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        @client = Client.find(params[:id])
        if @client.update(client_params)
          render json: {
            message: "Client updated successfully.",
            client: @client
          }, status: :ok
        else
          render json: {
            message: "Error when updating client.",
            errors: @client.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @client = Client.find(params[:id])
        if @client.destroy
          render json: {
          }, status: :no_content
        else
          render json: {
            message: "Error when deleting client.",
            errors: @client.errors.full_messages
          }, status: :unprocessable_entity
        end
      end


      def search
        if params[:q_cpf_cont].present?
          @clients = Client.where('cpf LIKE ?', "%#{params[:q_cpf_cont]}%")
        else
          render json: new_client_path
        end
        respond_to do |format|
          format.html { render :search_results }
          format.json { render json: @clients }
        end
      end

      def home
        @cpf = params[:cpf] if params[:cpf].present?
        render json: @cpf
      end

      private

      def client_params
        params.require(:client).permit(:cpf,:nome,:telefone,:email)
      end
    end
  end
end
