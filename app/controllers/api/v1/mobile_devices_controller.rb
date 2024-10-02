module Api
  module V1
      class MobileDevicesController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        instance_list = MobileDeviceManager::List.new.call
        if instance_list[:success]
          @mobile_devices = instance_list[:resources]
          render json: @mobile_devices.as_json(include: :tickets)
        else
          render json: instance_list, status: :unprocessable_entity
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

      private

      def mobile_device_params
        params.require(:mobile_device).permit(:imei,:serial,:modelo,:marca,:client_id)
      end
    end
  end
end