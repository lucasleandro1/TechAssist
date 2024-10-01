module TicketManager
  class Status
    attr_reader :status

    def initialize(status)
      @status = status
    end

    def call
      tickets = fetch_tickets
      format_response(tickets)
    end

    private

    def fetch_tickets
      Ticket.includes(mobile_device: :client).where(status: status)
    end

    def format_response(tickets)
      tickets.as_json(include: {
        mobile_device: {
          include: :client
        }
      })
    end
  end
end
