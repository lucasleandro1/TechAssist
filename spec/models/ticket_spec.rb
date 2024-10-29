require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let!(:user) { User.create(email: 'usuario@example.com', password: 'senha123') }
  let!(:client) { Client.create(nome: 'Cliente Exemplo', cpf: '12345678456', email: 'cliente@gmail.com', telefone: '88992109391') }
  let!(:device) { MobileDevice.create(client: client, imei: '1234578912345', serial: 'RX-TSNDFSZTO', modelo: 'SM-S907', marca: 'Samsung') }

  context 'validações' do
    it 'é válido com mobile_device, status, sintoma e descricao' do
      ticket = Ticket.new(user: user, mobile_device: device, status: 'Pendente', sintoma: 'Energia', descricao: 'problema na bateria')
      expect(ticket).to be_valid
    end

    it 'é inválido sem status' do
      ticket = Ticket.new(user: user, mobile_device: device, sintoma: 'Energia', descricao: 'problema na bateria')
      expect(ticket).to_not be_valid
    end

    it 'é inválido sem sintoma' do
      ticket = Ticket.new(user: user, mobile_device: device, descricao: 'problema na bateria')
      expect(ticket).to_not be_valid
    end

    it 'é inválido sem descricao' do
      ticket = Ticket.new(user: user, mobile_device: device, sintoma: 'Energia')
      expect(ticket).to_not be_valid
    end
  end

  context 'métodos de classe e instância' do
    describe '#close_ticket' do
      it 'fecha o ticket e define a data de fechamento' do
        ticket = Ticket.create(user: user, mobile_device: device, status: 'Pendente', sintoma: 'Energia', descricao: 'problema na bateria')
        ticket.close_ticket
        expect(ticket.status).to eq('Pedido entregue')
        expect(ticket.data_fechamento).not_to be_nil
      end
    end
  end
end
