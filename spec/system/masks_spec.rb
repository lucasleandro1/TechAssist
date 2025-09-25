require 'rails_helper'

RSpec.describe 'CPF and Phone Masks', type: :system do
  before do
    driven_by(:selenium, using: :headless_chrome)
  end

  describe 'Client form masks' do
    it 'applies CPF mask correctly' do
      visit new_client_path
      
      cpf_field = find('#client_cpf')
      cpf_field.fill_in with: '12345678901'
      
      # O campo deve formatar automaticamente
      expect(cpf_field.value).to eq('123.456.789-01')
    end

    it 'applies phone mask correctly for mobile' do
      visit new_client_path
      
      phone_field = find('#client_telefone')
      phone_field.fill_in with: '11987654321'
      
      # O campo deve formatar automaticamente
      expect(phone_field.value).to eq('(11) 98765-4321')
    end

    it 'applies phone mask correctly for landline' do
      visit new_client_path
      
      phone_field = find('#client_telefone')
      phone_field.fill_in with: '1134567890'
      
      # O campo deve formatar automaticamente
      expect(phone_field.value).to eq('(11) 3456-7890')
    end
  end

  describe 'CPF search mask' do
    it 'applies CPF mask to search field' do
      visit clients_path
      
      search_field = find('input[name="q_cpf_cont"]')
      search_field.fill_in with: '12345678901'
      
      # O campo deve formatar automaticamente
      expect(search_field.value).to eq('123.456.789-01')
    end
  end
end