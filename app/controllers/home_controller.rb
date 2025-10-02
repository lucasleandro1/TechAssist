class HomeController < ApplicationController
  def index
    @total_tickets = current_user.tickets.count
    @tickets_by_status = current_user.tickets.group(:status).count
    @total_clients = current_user.clients.distinct.count
    @total_devices = current_user.mobile_devices.distinct.count
    @recent_tickets = current_user.tickets.includes(mobile_device: :client).order(created_at: :desc).limit(5)
    @total_received = current_user.tickets.where(status: [2,5,6,7]).sum(:repair_price) || 0
  rescue
    @total_tickets = 0
    @tickets_by_status = {}
    @total_clients = 0
    @total_devices = 0
    @recent_tickets = []
    @total_received = 0
  end
end