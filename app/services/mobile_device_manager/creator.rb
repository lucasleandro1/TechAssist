module MobileDeviceManager
  class Creator
    attr_reader :mobile_device_params

    def initialize(mobile_device_params)
      @mobile_device_params = mobile_device_params
    end

    def call
      if mobile_device_exists
        response_error("Device already exists with this IMEI")
      else
        response(create_mobile_device)
      end
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: "Device created.", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def mobile_device_exists
      MobileDevice.exists?(imei: mobile_device_params[:imei])
    end

    def create_mobile_device
      mobile_device = MobileDevice.new(mobile_device_params)
      if mobile_device.save
        mobile_device
      else
        raise StandardError.new(mobile_device.errors.full_messages.to_sentence)
      end
    end
  end
end
