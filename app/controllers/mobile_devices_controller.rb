class MobileDevicesController < ApplicationController
  def search
    if params[:q_imei_cont].present?
      # Buscar via API
      response = api_request("GET", "/api/v1/search_mobile_devices", { q_imei_cont: params[:q_imei_cont] })
      @mobile_devices = response.is_a?(Array) ? response : []
    else
      @mobile_devices = []
    end
  end

  private

  def api_request(method, path, params = {})
    require 'net/http'
    require 'json'
    
    uri = URI("http://localhost:3001#{path}")
    uri.query = URI.encode_www_form(params) if method == "GET" && params.any?
    
    http = Net::HTTP.new(uri.host, uri.port)
    request = case method
              when "GET"
                Net::HTTP::Get.new(uri)
              when "POST"
                Net::HTTP::Post.new(uri)
                request.body = params.to_json
                request["Content-Type"] = "application/json"
              end
    
    response = http.request(request)
    JSON.parse(response.body) rescue []
  end
end