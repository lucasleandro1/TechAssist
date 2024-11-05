module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_devise_api_token!, :set_ticket, only: [:generate_pdf]

      def index
        instance_list = TicketManager::List.new.call
        if instance_list[:success]
          @tickets = instance_list[:resources]
          tickets_with_names = @tickets.map do |ticket|
            ticket.as_json(include: {
              mobile_device: {
                include: :client
              }
            })
          end
          render json: tickets_with_names
        else
          render json: instance_list, status: :unprocessable_entity
        end
      end

      def create
        creator = TicketManager::Creator.new(ticket_params)
        result = creator.call
        if result[:success]
          render json: result[:resource], status: :created
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      def show
        instance_finder = TicketManager::Finder.new(params[:id])
        result = instance_finder.call
        if result[:success]
          @ticket = result[:resources]
          ticket_json = @ticket.as_json(include: { mobile_device: { include: :client }})
          if @ticket.arquivos.attached?
            anexos = @ticket.arquivos.map do |arquivo|
              {
                url: url_for(arquivo),
                filename: arquivo.filename.to_s
              }
            end
            ticket_json.merge!(arquivos: anexos)
          end
          render json: ticket_json
        else
          render json: result, status: :unprocessable_entity
        end
      end

      def update
        ticket = Ticket.find(params[:id])
        if ticket.update(ticket_params)
          ticket.close_ticket if ticket.status == 'Pedido entregue'
          render json: ticket, status: :ok
        else
          render json: ticket.errors, status: :unprocessable_entity
        end
      end

      def status
        status_service = TicketManager::Status.new(params[:status])
        tickets = status_service.call
        render json: tickets, status: :ok
      end

      def destroy
        destroy_service = TicketManager::Destroyer.new(params[:id])
        result = destroy_service.call
        if result[:success]
          render json: result[:message], status: :ok
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end


      def generate_pdf
        pdf = Prawn::Document.new
        pdf.text "Orçamento de Reparo", size: 30, style: :bold
        pdf.move_down 20

        pdf.text "Nome do Cliente: #{@ticket.mobile_device.client.nome}"
        pdf.text "Data de abertura de OS: #{@ticket.data_abertura}"
        pdf.text "Ordem de serviço: #{@ticket.id}"
        pdf.text "Modelo do aparelho: #{@ticket.mobile_device.modelo}"
        pdf.text "Peças a serem trocadas: #{@ticket.pecas}"
        pdf.text "Custo do Reparo: R$ #{@ticket.repair_price}"

        pdf.move_down 30
        pdf.text "Técnico responsavel: #{@ticket.user.email}"
        pdf.text "Data: #{Time.current.strftime('%d/%m/%Y')}"

        send_data pdf.render, filename: "orcamento_ticket_#{@ticket.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end

      private

      def set_ticket
        @ticket = Ticket.find(params[:id])
      end

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                       :comentario, :sintoma, :anexo, :repair_price,
                                       :mobile_device_id, arquivos: [], pecas: []).merge(user_id: current_devise_api_user.id)
      end
    end
  end
end