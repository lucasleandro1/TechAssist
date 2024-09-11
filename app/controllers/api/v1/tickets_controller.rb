module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_devise_api_token!

      def index
        @tickets = Ticket.all
        render json: @tickets
      end

      def create
        @ticket = Ticket.new(ticket_params)
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
        @ticket = Ticket.find(params[:id])
        @aparelho = @ticket.mobile_device
      end

      def update
        @ticket = Ticket.find(params[:id])
        if @ticket.update(ticket_params)
          flash[:notice] = "ticket atualizado com sucesso."
          redirect_to root_path
        else
          flash[:error] = "ticket não atualizado."
          render :edit
        end
      end

      def status
        @status = params[:status]
        @tickets = Ticket.includes(client: :mobile_device).where(status: @status)
        render json: @tickets.to_json(include: {
          client: {
            include: :mobile_device
          }
        })
      end

      def destroy
        @ticket = Ticket.find(params[:id])
        @ticket.destroy
        redirect_to tickets_path, notice: 'ticket excluído com sucesso.'
      end

      private

      def parsed_params
        ticket_params.tap do |hash|
          hash["sintoma"] = ticket_params["sintoma"].to_i
          hash["pecas"] = ticket_params["pecas"].to_i
          hash["status"] = ticket_params["status"].to_i
        end
      end

      def ticket_params
        params.require(:ticket).permit(:data_abertura, :data_fechamento, :descricao, :status,
                                        :comentario, :sintoma, :anexo, :pecas,
                                        :mobile_device_id, :user_id)
      end
    end
  end
end