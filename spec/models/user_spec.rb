require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_email) { 'usuario123@example.com' }
  let(:valid_password) { 'senha123' }

  context 'validações' do
    it 'é válido com atributos válidos' do
      user = User.create(email: valid_email, password: valid_password)
      expect(user).to be_valid
    end

    it 'é inválido sem um email' do
      user = User.new(password: valid_password)
      expect(user).to_not be_valid
    end

    it 'é inválido sem uma senha' do
      user = User.new(email: valid_email)
      expect(user).to_not be_valid
    end

    it 'é inválido com email duplicado' do
      User.create(email: valid_email, password: valid_password)
      duplicate_user = User.new(email: valid_email, password: valid_password)
      expect(duplicate_user).to_not be_valid
    end
  end

  context 'métodos de classe' do
    describe '.find_by_email' do
      it 'encontra um usuário pelo email' do
        user = User.create(email: valid_email, password: valid_password)
        found_user = User.find_by_email(valid_email)
        expect(found_user).to eq(user)
      end

      it 'retorna nil se o usuário não existir' do
        found_user = User.find_by_email('naoexistente@example.com')
        expect(found_user).to be_nil
      end
    end
  end
end
