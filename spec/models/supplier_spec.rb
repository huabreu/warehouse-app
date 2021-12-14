require 'rails_helper'

RSpec.describe Supplier, type: :model do
  context 'some fields are mandatory' do
    it 'trade_name is madatory' do

      supplier = Supplier.new(trade_name: '', company_name: 'Fornecedor Bonito e Formoso SA', 
                      cnpj: '1234567891234', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end

    it 'company_name is madatory' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: '', 
                      cnpj: '1234567891234', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end

    it 'cnpj is madatory' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                      cnpj: '', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end

    it 'e-mail is madatory' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                      cnpj: '1234567891234', address: 'Rua Bonita', email: '', phone: '321654')

      expect(supplier).not_to be_valid
    end
  end

  it 'cnpj must be unique' do

    Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567891234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
    supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                      cnpj: '1234567891234', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

    expect(supplier).not_to be_valid
  end

  context 'cnpj must have exactly 13 digits' do
    it 'cnpj equal to 12345678912' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                        cnpj: '12345678912', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end

    it 'cnpj equal to 12345678912232' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                        cnpj: '12345678912323223', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end

    it 'cnpj equal to 123456789112a' do

      supplier = Supplier.new(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
                        cnpj: '123456789112a', address: 'Rua Bonita', email: 'fbonito@hotmail.com', phone: '321654')

      expect(supplier).not_to be_valid
    end
  end
end
