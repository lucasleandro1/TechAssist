module MobileDeviceManager
  class Finder
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
      { success: true, resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      MobileDevice.includes(:client, :tickets).find(mobile_device_id)
    end
  end
end