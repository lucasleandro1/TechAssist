module MobileDeviceManager
  class Updater
    attr_reader :mobile_device_params, :mobile_device_id

    def initialize(mobile_device_id, mobile_device_params)
      @mobile_device_id = mobile_device_id
      @mobile_device_params = mobile_device_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error(I18n.t("activerecord.errors.messages.device_notfound #{e.message}"))
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.device_updated"), resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @mobile_device = MobileDevice.find(mobile_device_id)
      unless @mobile_device.update(mobile_device_params)
        raise StandardError.new(mobile_device.errors.full_messages.to_sentence)
      end
    end
  end
end