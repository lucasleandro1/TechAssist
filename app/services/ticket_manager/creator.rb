module TicketManager
  class Creator
    def initialize(ticket_params)
      @ticket_params = ticket_params
    end

    def call
      if ticket_exists
        response_error("Ticket already exists for this device with the same status.")
      else
        response(create_ticket)
      end
    rescue StandardError => error
      response_error(error)
    end

    private

    def parsed_params
      @ticket_params.tap do |hash|
        hash["sintoma"] = @ticket_params["sintoma"].to_i
        hash["pecas"] = @ticket_params["pecas"].to_i
        hash["status"] = @ticket_params["status"].to_i
        hash["user_id"] = @ticket_params["user_id"].to_i
      end
    end

    def response(data)
      { success: true, resource: data }
    end

    def response_error(error)
      { success: false, error_message: error }
    end

    def ticket_exists
      Ticket.exists?(mobile_device_id: @ticket_params[:mobile_device_id], status: [0,1,2,3])
    end

    def create_ticket
      ticket = Ticket.new(parsed_params)
      ticket.data_abertura = Time.current
      if ticket.save
        ticket
      else
        raise StandardError.new(ticket.errors.full_messages.to_sentence)
      end
    end
  end
end
