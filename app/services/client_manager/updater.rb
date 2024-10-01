module ClientManager
  class Updater
    attr_reader :client_params, :client_id

    def initialize(client_id, client_params)
      @client_id = client_id
      @client_params = client_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error("Client not found: #{e.message}")
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: "Client updated.", resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @client = Client.find(client_id)
      unless @client.update(client_params)
        raise StandardError.new(client.errors.full_messages.to_sentence)
      end
    end
  end
end