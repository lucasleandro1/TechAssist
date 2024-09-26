module Api
  module V1
    class ClientsController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        instance_list = ClientManager::List.new.call
        if instance_list[:success]
          @clients = instance_list[:resources]
          render json: @clients.as_json(include: {
            mobile_devices: {
              include: :tickets
            }
          })
        else
          render json: instance_list, status: :unprocessable_entity
        end
      end

      def create
        creator_service = ClientManager::Creator.new(client_params)
        result = creator_service.call
        if result[:success]
          render json: result[:resource], status: :created
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
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

      def show
        @clients = Client.includes(mobile_devices: :tickets).find(params[:id])
        render json: @clients.as_json(include: {
          mobile_devices: {
            include: :tickets
          }
        })
      end

      def search
        if params[:q_cpf_cont].present?
          @clients = Client.where('cpf LIKE ?', "%#{params[:q_cpf_cont]}%")
          render json: @clients, status: :ok
        else
          render json: { message: "CPF query parameter is missing." }, status: :bad_request
        end
      end

      private

      def client_params
        params.require(:client).permit(:cpf,:nome,:telefone,:email)
      end

    end
  end
end
