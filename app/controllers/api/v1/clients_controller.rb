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
        update_service = ClientManager::Updater.new(params[:id], client_params)
        result = update_service.call
        if result[:success]
          render json: result[:resource], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
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
        instance_finder = ClientManager::Finder.new(params[:id])
        result = instance_finder.call
        if result[:success]
          @client = result[:resources]
          render json: @client.as_json(include: {
            mobile_devices: {
              include: :tickets
            }
          })
        else
          render json: result, status: :unprocessable_entity
        end
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
