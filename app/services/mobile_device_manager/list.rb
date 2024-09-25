module MobileDeviceManager
  class List
    def initialize
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
      MobileDevice.includes(:tickets).all
    end
  end
end