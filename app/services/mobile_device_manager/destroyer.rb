module MobileDeviceManager
  class Destroyer
    attr_reader :mobile_device_id

    def initialize(mobile_device_id)
      @mobile_device_id = mobile_device_id
    end

    def call
      response(scope)
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: "Device delete.", resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def scope
      @mobile_device = MobileDevice.find(mobile_device_id)
      unless @mobile_device.destroy
        raise StandardError.new(mobile_device.errors.full_messages.to_sentence)
      end
    end
  end
end