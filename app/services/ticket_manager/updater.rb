module TicketManager
  class Updater
    attr_reader :ticket_params, :ticket_id

    def initialize(ticket_id, ticket_params)
      @ticket_id = ticket_id
      @ticket_params = ticket_params
    end

    def call
      response(scope)
    rescue ActiveRecord::RecordNotFound => e
      response_error(I18n.t("activerecord.errors.messages.ticket_notfound #{e.message}"))
    rescue StandardError => error
      response_error(error)
    end

    private

    def response(data)
      { success: true, message: I18n.t("activerecord.errors.messages.ticket_updated"), resources: data }
    end

    def response_error(error)
      { success: false, error_message: error.message }
    end

    def scope
      ticket = Ticket.find(ticket_id)
      unless ticket.update(ticket_params)
        raise StandardError.new(ticket.errors.full_messages.to_sentence)
      end
    end
  end
end