module Api
  module V1
      class MobileDevicesController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        @mobile_devices = MobileDevice.includes(:tickets).all
        render json: @mobile_devices.as_json(include: :tickets)
      end

      def create
        if MobileDevice.exists?(imei: mobile_device_params[:imei])
          render json: {
            message: "Device with this IMEI already exists."
          }, status: :unprocessable_entity
        else
          @mobile_device = MobileDevice.new(mobile_device_params)
          if @mobile_device.save
            render json:{
              message: "Device created successfully.",
              mobile_device: @mobile_device
            }, status: :created
          else
            render json: {
              message: "Error when registering Device.",
              errors: @mobile_device.errors.full_messages
            }, status: :unprocessable_entity
          end
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