module TicketManager
  class Destroyer
    attr_reader :ticket_id

    def initialize(ticket_id)
      @ticket_id = ticket_id
    end

    def call
      response(scope)
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: "Ticket delete.",resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      @ticket = Ticket.find(ticket_id)
      unless @ticket.destroy
        raise StandardError.new(ticket.errors.full_messages.to_sentence)
      end
    end
  end
end