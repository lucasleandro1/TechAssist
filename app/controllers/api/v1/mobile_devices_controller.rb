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
        @mobile_device = MobileDevice.find(params[:id])
        if @mobile_device.update(mobile_device_params)
          render json: {
            message: "Device updated successfully.",
            client: @mobile_device
          }, status: :ok
        else
          render json: {
            message: "Error when updating Device.",
            errors: @mobile_device.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @mobile_device = MobileDevice.find(params[:id])
        if @mobile_device.destroy
          render json: {
          }, status: :no_content
        else
          render json: {
            message: "Error when deleting Device.",
            errors: @mobile_device.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def mobile_device_params
        params.require(:mobile_device).permit(:imei,:serial,:modelo,:marca,:client_id)
      end
    end
  end
end