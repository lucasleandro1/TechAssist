require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:valid_nome) { 'Cliente Exemplo' }
  let(:valid_cpf) { '12345678901' }
  let(:valid_email) { 'cliente@gmail.com' }
  let(:valid_telefone) { '88992109391' }

  context 'validações' do
    it 'é válido com atributos válidos' do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
      expect(client).to be_valid
    end

    it 'é inválido sem nome' do
      client = Client.new(cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it 'é inválido sem email' do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it 'é inválido sem telefone' do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, email: valid_email)
      expect(client).to_not be_valid
    end

    it 'é inválido sem cpf' do
      client = Client.new(nome: valid_nome, email: valid_email, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it 'é inválido com CPF duplicado' do
      Client.create(nome: 'Cliente 1', cpf: valid_cpf)
      client = Client.new(nome: 'Cliente 2', cpf: valid_cpf)
      expect(client).to_not be_valid
    end
  end

  context 'métodos de classe' do
    describe '.find_by_cpf' do
      it 'encontra um cliente pelo CPF' do
        client = Client.create(nome: valid_nome, cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
        found_client = Client.find_by(cpf: valid_cpf)
        expect(found_client).to eq(client)
      end

      it 'retorna nil se o cliente não existir' do
        found_client = Client.find_by(cpf: '00000000000')
        expect(found_client).to be_nil
      end
    end
  end
end
