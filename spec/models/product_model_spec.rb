require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  context 'All fields are mandatory' do
    it 'Supplier is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: nil, sku_code: 'TCDD2123212322ASD2313',
                                 weight: 200, width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Name is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'', supplier: supplier, sku_code: 'TCDD2123212322ASD2313',
                                 weight: 200, width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'SKU is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: '',
                                 weight: 200, width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Weight is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD2313',
                                 weight: '', width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Width is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD2313',
                                 weight: 200, width: '', height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Height is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD2313',
                                 weight: 200, width: 30, height: '', length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Length is mandatory' do
      supplier = Supplier.create(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD2313',
                                 weight: 200, width: 30, height: 5, length: '')
    
      expect(product).not_to be_valid
    end
  end
end
