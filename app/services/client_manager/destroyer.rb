module ClientManager
  class Destroyer
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
      { success: true, message: "Client delete.",resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def scope
      @client = Client.find(client_id)
      unless @client.destroy
        raise StandardError.new(client.errors.full_messages.to_sentence)
      end
    end
  end
end