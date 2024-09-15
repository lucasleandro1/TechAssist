module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        @tickets = Ticket.includes(mobile_device: :client).all
        render json: @tickets.as_json(include: {
          mobile_device: {
            include: :client
          }
        })
      end

      def create
        @ticket = Ticket.new(parsed_params)
        if @ticket.save
          render json: {
            message: "Ticket created successfully.",
            ticket: @ticket
          }, status: :created
        else
          render json: {
            message: "Error when registering ticket.",
            errors: @ticket.errors.full_messages
          }, status: :unprocessable_entity
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

      def parsed_params
        ticket_params.tap do |hash|
          hash["sintoma"] = ticket_params["sintoma"].to_i
          hash["pecas"] = ticket_params["pecas"].to_i
          hash["status"] = ticket_params["status"].to_i
          hash["user_id"] = current_devise_api_user.id
        end
      end

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                        :comentario, :sintoma, :anexo, :pecas,
                                        :mobile_device_id)
      end
    end
  end
end