class HomeController < ApplicationController
  def index
    @total_tickets = Ticket.count
    @tickets_by_status = Ticket.group(:status).count
    @total_clients = Client.count
    @total_devices = MobileDevice.count
    @recent_tickets = Ticket.includes(mobile_device: :client).order(created_at: :desc).limit(5)
    @total_received = Setting.first&.total_received || 0
  rescue
    @total_tickets = 0
    @tickets_by_status = {}
    @total_clients = 0
    @total_devices = 0
    @recent_tickets = []
    @total_received = 0
  end
end