require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_cpf' do
    it 'formats a clean CPF correctly' do
      expect(helper.format_cpf('12345678901')).to eq('123.456.789-01')
    end

    it 'returns formatted CPF as is' do
      expect(helper.format_cpf('123.456.789-01')).to eq('123.456.789-01')
    end

    it 'returns original value for invalid CPF length' do
      expect(helper.format_cpf('123456789')).to eq('123456789')
    end

    it 'handles nil CPF' do
      expect(helper.format_cpf(nil)).to be_nil
    end

    it 'handles blank CPF' do
      expect(helper.format_cpf('')).to eq('')
    end
  end

  describe '#format_phone' do
    it 'formats mobile phone correctly' do
      expect(helper.format_phone('11987654321')).to eq('(11) 98765-4321')
    end

    it 'formats landline phone correctly' do
      expect(helper.format_phone('1134567890')).to eq('(11) 3456-7890')
    end

    it 'returns formatted phone as is' do
      expect(helper.format_phone('(11) 98765-4321')).to eq('(11) 98765-4321')
    end

    it 'returns original value for invalid phone length' do
      expect(helper.format_phone('123456789')).to eq('123456789')
    end

    it 'handles nil phone' do
      expect(helper.format_phone(nil)).to be_nil
    end

    it 'handles blank phone' do
      expect(helper.format_phone('')).to eq('')
    end
  end

  describe '#clean_cpf' do
    it 'removes formatting from CPF' do
      expect(helper.clean_cpf('123.456.789-01')).to eq('12345678901')
    end

    it 'handles already clean CPF' do
      expect(helper.clean_cpf('12345678901')).to eq('12345678901')
    end

    it 'handles nil CPF' do
      expect(helper.clean_cpf(nil)).to be_nil
    end
  end

  describe '#clean_phone' do
    it 'removes formatting from phone' do
      expect(helper.clean_phone('(11) 98765-4321')).to eq('11987654321')
    end

    it 'handles already clean phone' do
      expect(helper.clean_phone('11987654321')).to eq('11987654321')
    end

    it 'handles nil phone' do
      expect(helper.clean_phone(nil)).to be_nil
    end
  end
end