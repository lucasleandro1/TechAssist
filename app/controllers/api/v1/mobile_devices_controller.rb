module Api
  module V1
    class MobileDevicesController < ApplicationController
      # before_action :authenticate_devise_api_token!

      def index
        if current_devise_api_user
          @mobile_devices = current_devise_api_user.mobile_devices.distinct.includes(:tickets)
          render json: @mobile_devices.as_json(include: :tickets)
        else
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      def create
        creator_service = MobileDeviceManager::Creator.new(mobile_device_params)
        result = creator_service.call
        if result[:success]
          render json: result[:resource], status: :created
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def show
        instance_finder = MobileDeviceManager::Finder.new(params[:id])
        result = instance_finder.call
        if result[:success]
          @mobile_device = result[:resources]
          render json: @mobile_device.as_json(include: {
            client: { only: [:id, :nome, :cpf] },
            tickets: { only: [:id, :status, :created_at] }
          })
        else
          render json: result, status: :unprocessable_entity
        end
      end

      def update
        update_service = MobileDeviceManager::Updater.new(params[:id], mobile_device_params)
        result = update_service.call
        if result[:success]
          render json: result[:message], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def destroy
        destroy_service = MobileDeviceManager::Destroyer.new(params[:id])
        result = destroy_service.call
        if result[:success]
          render json: result[:message], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def search
        service = MobileDeviceManager::Search.new(params)
        result = service.call
        if result[:error].present?
          render json: { message: result[:error] }, status: result[:status]
        else
          @mobile_device = result[:mobile_device]
          render json: @mobile_device.as_json(include: {
            client: { only: [:id, :nome, :cpf]}})
        end
      end

      private

      def mobile_device_params
        params.require(:mobile_device).permit(:imei, :serial, :modelo, :marca, :client_id)
      end
    end
  end
end