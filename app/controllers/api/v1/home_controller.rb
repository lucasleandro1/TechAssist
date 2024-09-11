module Api
  module V1
    class HomeController < ApplicationController
      before_action :authenticate_devise_api_token!
      def index
      end
    end
  end
end