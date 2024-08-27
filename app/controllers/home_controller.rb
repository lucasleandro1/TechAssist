class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @ticket = Ticket.all
  end
end
