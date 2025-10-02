module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_devise_api_token!, :set_ticket, only: [:generate_pdf]

      def index
        @tickets = current_devise_api_user.tickets.includes(mobile_device: :client)
        tickets_with_names = @tickets.map do |ticket|
          ticket.as_json(include: {
            mobile_device: {
              include: :client
            }
          })
        end
        render json: tickets_with_names
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
        service = TicketManager::Finder.new(params[:id])
        result = service.call
        if result[:success]
          render json: result[:resources]
        else
          render json: { error: result[:message] }, status: :unprocessable_entity
        end
      end

      def update
        ticket = Ticket.find(params[:id])
        if ticket.update(ticket_params)
          ticket.close_ticket if ticket.status == "Pedido entregue" || ticket.status == "Pedido reprovado entregue"
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

      def received
        total_received = Setting.first.total_received
        render json: { total_received: total_received }, status: :ok
      end

      def generate_pdf
        ticket = Ticket.find(params[:id])
        pdf_data = TicketManager::PdfGenerator.new(ticket).generate
        send_data pdf_data, filename: "orcamento_ticket_#{ticket.id}.pdf",
                            type: "application/pdf",
                            disposition: "inline"
      end

      private

      def set_ticket
        @ticket = current_devise_api_user.tickets.find(params[:id])
      end

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                       :comentario, :sintoma, :repair_price,
                                       :mobile_device_id, arquivos: [], pecas: []).merge(user_id: current_devise_api_user.id)
      end
    end
  end
end