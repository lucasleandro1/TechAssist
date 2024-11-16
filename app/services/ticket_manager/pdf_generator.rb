module TicketManager
  class PdfGenerator
    def initialize(ticket)
      @ticket = ticket
    end

    def generate
      pdf = Prawn::Document.new
      pdf.text "Orçamento do Reparo", size: 30, style: :bold
      pdf.move_down 20

      pdf.text "Nome do Cliente: #{@ticket.mobile_device.client.nome}"
      pdf.text "CPF: #{@ticket.mobile_device.client.cpf}"
      pdf.text "Data de abertura de OS: #{@ticket.data_abertura}"
      pdf.text "Ordem de serviço: #{@ticket.id}"
      pdf.text "Modelo do aparelho: #{@ticket.mobile_device.modelo}"
      pdf.text "Marca do aparelho: #{@ticket.mobile_device.marca}"
      pecas_nomes = @ticket.pecas.map { |indice| Ticket::PECAS.key(indice) }.compact
      pdf.text "Peças a serem trocadas: #{pecas_nomes.join(', ')}"
      pdf.text "Custo do Reparo: R$ #{@ticket.repair_price}"

      pdf.move_down 30
      pdf.text "Técnico responsável: #{extract_name(@ticket.user.email)}"
      pdf.text "Data: #{Time.current.strftime('%d/%m/%Y')}"

      pdf.render
    end

    private

    def extract_name(email)
      nome_completo = email.split('@').first
      nome_completo = nome_completo.split('_').map(&:capitalize).join(' ')
      nome_completo
    end
  end
end
