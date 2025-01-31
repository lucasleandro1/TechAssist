module ClientManager
  class Creator
    attr_reader :client_params

    def initialize(client_params)
      @client_params = client_params
    end

    def call
      if client_exists
        response_error(message: I18n.t("activerecord.errors.messages.client_exists"))
      else
        response(create_client)
      end
    rescue StandardError => error
      response_error(error.message)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.client_created"), resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def client_exists
      Client.exists?(cpf: client_params[:cpf])
    end

    def create_client
      client = Client.new(client_params)
      if client.save
        client
      else
        raise StandardError.new(client.errors.full_messages.to_sentence)
      end
    end
  end
end
