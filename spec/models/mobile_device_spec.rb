# frozen_string_literal: true

require "rails_helper"

RSpec.describe MobileDevice, type: :model do
  let(:client) { Client.create(nome: "Cliente Exemplo", cpf: "12345678901", email: "cliente@gmail.com", telefone: "88992109391") }
  let(:valid_imei) { "1234578912345" }
  let(:valid_serial) { "RX-TSNDFSZTO" }
  let(:valid_modelo) { "SM-S907" }
  let(:valid_marca) { "Samsung" }

  context "validações" do
    it "é válido com todas as informações" do
      device = MobileDevice.new(client_id: client.id, imei: valid_imei, serial: valid_serial, modelo: valid_modelo, marca: valid_marca)
      expect(device).to be_valid
    end

    it "é inválido sem o imei" do
      device = MobileDevice.new(client_id: client, serial: valid_serial, modelo: valid_modelo, marca: valid_marca)
      expect(device).to_not be_valid
    end

    it "é inválido sem o serial" do
      device = MobileDevice.new(client_id: client, imei: valid_imei, modelo: valid_modelo, marca: valid_marca)
      expect(device).to_not be_valid
    end

    it "é inválido sem o modelo" do
      device = MobileDevice.new(client_id: client, imei: valid_imei, serial: valid_serial, marca: valid_marca)
      expect(device).to_not be_valid
    end

    it "é inválido sem a marca" do
      device = MobileDevice.new(client_id: client, imei: valid_imei, serial: valid_serial, modelo: valid_modelo)
      expect(device).to_not be_valid
    end

    it "é inválido com imei duplicado" do
      MobileDevice.create(imei: valid_imei, client_id: client)
      device = MobileDevice.new(imei: valid_imei, client_id: client)
      expect(device).to_not be_valid
    end
  end
end
