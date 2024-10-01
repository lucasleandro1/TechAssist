module TicketManager
  class Finder
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
      { success: true, resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      Ticket.includes(mobile_device: :client).find(ticket_id)
    end
  end
end