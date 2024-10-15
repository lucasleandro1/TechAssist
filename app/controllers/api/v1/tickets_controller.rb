module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        instance_list = TicketManager::List.new.call
        if instance_list[:success]
          @tickets = instance_list[:resources]
          render json: @tickets.as_json(include: {
            mobile_device: {
              include: :client
            }
          })
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
          if @ticket.arquivo.attached?
            ticket_json.merge!(arquivo: {
              url: url_for(@ticket.arquivo),
              filename: @ticket.arquivo.filename.to_s
            })
          end
          render json: ticket_json
        else
          render json: result, status: :unprocessable_entity
        end
      end

      def update
        ticket = Ticket.find(params[:id])
        if ticket.update(ticket_params)
          ticket.update(data_fechamento: ticket.updated_at)
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

      private

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                       :comentario, :sintoma, :anexo, :pecas,
                                       :mobile_device_id, :arquivo)
              .merge(user_id: current_devise_api_user.id,
                     data_abertura: Time.current,
                     data_fechamento: Time.current)
      end

    end
  end
end