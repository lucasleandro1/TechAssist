module Api
  module V1
    class ClientsController < ApplicationController
      # before_action :authenticate_devise_api_token!

      def index
        if current_devise_api_user
          @clients = current_devise_api_user.clients.distinct
          render json: @clients.as_json(include: {mobile_devices: { only: [:id, :marca, :modelo], include: {tickets: { only: [:id, :status, :created_at]}}}})
        else
          render json: { error: "Unauthorized" }, status: :unauthorized
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
          render json: result[:message], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def destroy
        destroy_service = ClientManager::Destroyer.new(params[:id])
        result = destroy_service.call
        if result[:success]
          render json: result[:messages], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def show
        instance_finder = ClientManager::Finder.new(params[:id])
        result = instance_finder.call
        if result[:success]
          @client = result[:resources]
          render json: @client.as_json(include: {
            mobile_devices: { only: [:id, :marca, :modelo], include: {tickets: { only: [:id, :status, :created_at]}}}})
        else
          render json: result, status: :unprocessable_entity
        end
      end

      def search
        service = ClientManager::Search.new(params)
        result = service.call
        if result[:error].present?
          render json: { message: result[:error] }, status: result[:status]
        else
          render json: result[:clients], status: result[:status]
        end
      end

      private

      def client_params
        params.require(:client).permit(:cpf,:nome,:telefone,:email)
      end

    end
  end
end
