module TicketManager
  class Finder
    attr_reader :ticket_id

    def initialize(ticket_id)
      @ticket_id = ticket_id
    end

    def call
      ticket = find_ticket
      return { success: false, message: I18n.t("activerecord.errors.messages.ticket_notfound") } unless ticket 

      ticket_json = format_ticket(ticket)
      ticket_json.merge!(add_attachments(ticket)) if ticket.arquivos.attached?

      { success: true, resources: ticket_json }
    end

    private

    def find_ticket
      Ticket.find_by(id: @ticket_id)
    end

    def format_ticket(ticket)
      ticket.as_json(include: { mobile_device: { include: :client } })
    end

    def add_attachments(ticket)
      anexos = ticket.arquivos.map do |arquivo|
        {
          url: Rails.application.routes.url_helpers.rails_blob_url(arquivo, host: "http://localhost:3000"),
          filename: arquivo.filename.to_s
        }
      end
      { arquivos: anexos }
    end
  end
end
