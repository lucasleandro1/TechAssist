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
        @tickets = Ticket.includes(mobile_device: :client).find(params[:id])
        render json: @tickets.as_json(include: {
          mobile_device: {
            include: :client
          }
        })
      end

      def update
        @ticket = Ticket.find(params[:id])
        if @ticket.update(ticket_params)
          render json: { message: "Ticket updated successfully.", ticket: @ticket}, status: :ok
        else
          render json: {message: "Error when updating ticket.", errors: @ticket.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def status
        @status = params[:status]
        @tickets = Ticket.includes(mobile_device: :client).where(status: @status)
        render json: @tickets.as_json(include: {
          mobile_device: {
            include: :client
          }
        })
      end

      def destroy
        @ticket = Ticket.find(params[:id])
        if @ticket.destroy
          render json: {message: "Ticket deleted successfully."}, status: :ok
        else
          render json: {message: "Error when deleting ticket.", errors: @ticket.errors.full_messages}, status: :unprocessable_entity    
        end
      end

      private

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                        :comentario, :sintoma, :anexo, :pecas,
                                        :mobile_device_id).merge(user_id: current_devise_api_user.id)
      end
    end
  end
end