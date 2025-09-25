# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client, type: :model do
  let(:valid_nome) { "Cliente Exemplo" }
  let(:valid_cpf) { "11144477735" }  # CPF válido matematicamente
  let(:valid_email) { "cliente@gmail.com" }
  let(:valid_telefone) { "88992109391" }

  context "validações" do
    it "é válido com atributos válidos" do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
      expect(client).to be_valid
    end

    it "é inválido sem nome" do
      client = Client.new(cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it "é inválido sem email" do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it "é inválido sem telefone" do
      client = Client.new(nome: valid_nome, cpf: valid_cpf, email: valid_email)
      expect(client).to_not be_valid
    end

    it "é inválido sem cpf" do
      client = Client.new(nome: valid_nome, email: valid_email, telefone: valid_telefone)
      expect(client).to_not be_valid
    end

    it "é inválido com CPF duplicado" do
      Client.create(nome: "Cliente 1", cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
      client = Client.new(nome: "Cliente 2", cpf: valid_cpf, email: "outro@email.com", telefone: "11987654322")
      expect(client).to_not be_valid
    end
  end

  context "validação de CPF" do
    it "aceita CPF válido" do
      client = Client.new(nome: valid_nome, cpf: '11144477735', email: valid_email, telefone: valid_telefone)
      expect(client).to be_valid
    end

    it "rejeita CPF com tamanho incorreto" do
      client = Client.new(nome: valid_nome, cpf: '123456789', email: valid_email, telefone: valid_telefone)
      expect(client).not_to be_valid
      expect(client.errors[:cpf]).to include('deve ter 11 dígitos')
    end

    it "rejeita CPF inválido (todos os dígitos iguais)" do
      client = Client.new(nome: valid_nome, cpf: '11111111111', email: valid_email, telefone: valid_telefone)
      expect(client).not_to be_valid
      expect(client.errors[:cpf]).to include('não é um CPF válido')
    end

    it "rejeita CPF com dígitos verificadores inválidos" do
      client = Client.new(nome: valid_nome, cpf: '12345678900', email: valid_email, telefone: valid_telefone)
      expect(client).not_to be_valid
      expect(client.errors[:cpf]).to include('não é um CPF válido')
    end
  end

  context "validação de telefone" do
    it "aceita telefone celular válido (11 dígitos)" do
      client = Client.new(nome: valid_nome, cpf: '11144477735', email: valid_email, telefone: '11987654321')
      expect(client).to be_valid
    end

    it "aceita telefone fixo válido (10 dígitos)" do
      client = Client.new(nome: valid_nome, cpf: '11144477735', email: valid_email, telefone: '1134567890')
      expect(client).to be_valid
    end

    it "rejeita telefone com tamanho incorreto" do
      client = Client.new(nome: valid_nome, cpf: '11144477735', email: valid_email, telefone: '123456789')
      expect(client).not_to be_valid
      expect(client.errors[:telefone]).to include('deve ter 10 ou 11 dígitos')
    end
  end

  context "limpeza de dados antes de salvar" do
    it "remove formatação do CPF e telefone antes de salvar" do
      client = Client.create!(nome: valid_nome, cpf: '111.444.777-35', email: valid_email, telefone: '(11) 98765-4321')
      client.reload
      expect(client.cpf).to eq('11144477735')
      expect(client.telefone).to eq('11987654321')
    end

    it "mantém dados já limpos" do
      client = Client.create!(nome: valid_nome, cpf: '11144477735', email: valid_email, telefone: '11987654321')
      client.reload
      expect(client.cpf).to eq('11144477735')
      expect(client.telefone).to eq('11987654321')
    end
  end

  context "métodos de classe" do
    describe ".find_by_cpf" do
      it "encontra um cliente pelo CPF" do
        client = Client.create(nome: valid_nome, cpf: valid_cpf, email: valid_email, telefone: valid_telefone)
        found_client = Client.find_by(cpf: valid_cpf)
        expect(found_client).to eq(client)
      end

      it "retorna nil se o cliente não existir" do
        found_client = Client.find_by(cpf: "00000000000")
        expect(found_client).to be_nil
      end
    end
  end
end
