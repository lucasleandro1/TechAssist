module TicketManager
  class Received
    attr_reader :status

    def initialize(status)
      @status = status
    end

    def call
      if [2, 5, 6, 7].include?(status)
        calculate_paid_repair
      else
        calculate_not_paid_repair
      end
    end

    private

    def calculate_paid_repair
      Ticket.where(status: [2,5,6,7]).sum(:repair_price)
    end

    def calculate_not_paid_repair
      0
    end
  end
end
