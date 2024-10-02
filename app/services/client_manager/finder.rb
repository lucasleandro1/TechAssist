module ClientManager
  class Finder
    attr_reader :client_id

    def initialize(client_id)
      @client_id = client_id
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
      Client.includes(mobile_devices: :tickets).find(client_id)
    end
  end
end