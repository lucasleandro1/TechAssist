module MobileDeviceManager
  class Search
    def initialize(params)
      @params = params
    end

    def call
      if @params[:q_imei_cont].present?
        search_imei
      else
        { message: I18n.t("activerecord.errors.messages.imei_blank"), status: :bad_request }
      end
    end

    private

    def search_imei
      imei = @params[:q_imei_cont]
      mobile_device = MobileDevice.find_by(imei: imei)
      if mobile_device.present?
        { mobile_device: [mobile_device], status: :ok }
      else
        { message: I18n.t("activerecord.errors.messages.mobile_notfound_imei"), status: :not_found }
      end
    end

  end
end
