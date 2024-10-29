# spec/services/client_manager/creator_spec.rb
require 'rails_helper'

RSpec.describe ClientManager::Creator do
  context 'Validações' do
    it 'é válido com todos os atributos válidos' do
      valid_attributes = { nome: 'Cliente Exemplo', cpf: '12345678901', email: 'client@gmail.com', telefone: '87992109391' }
      creator_service = described_class.new(valid_attributes)
      result = creator_service.call

      expect(result.success?).to be true
      expect(result.resource).to be_a(Client)
    end

    it 'é inválido com atributos faltantes ou incorretos' do
      invalid_attributes = { nome: '', cpf: 'cpf_invalido' }
      creator_service = described_class.new(invalid_attributes)
      result = creator_service.call

      expect(result.failure?).to be true
      expect(result.error_message).to be_present
    end
  end
end
