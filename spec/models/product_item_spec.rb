require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  context 'SKU code' do
    it 'must be auto generated' do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
        cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      category = ProductCategory.create!(name: 'Eletrônicos Potentes')
      product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, 
                          product_category: category, weight: 200, width: 30, height: 5, length: 12)
      pi = ProductItem.create!(warehouse: warehouse, product_model: product)
    
      expect(pi.sku_code).not_to eq nil
    end

    it 'must have 20 characters' do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
        cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      category = ProductCategory.create!(name: 'Eletrônicos Potentes')
      product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, 
                          product_category: category, weight: 200, width: 30, height: 5, length: 12)
      pi = ProductItem.create!(warehouse: warehouse, product_model: product)

      expect(pi.sku_code.length).to be_equal 20
    end
    
    it 'must be unique' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      category = ProductCategory.create!(name: 'Eletrônicos Potentes')
      product1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, 
                          product_category: category, weight: 200, width: 30, height: 5, length: 12)
      sku = product1.sku_code

      product2 = ProductModel.new(name:'Som Bacana', supplier: supplier,
      weight: 400, width: 30, height: 32, length: 12)
      allow(SecureRandom).to receive(:alphanumeric).with(20).and_return sku
      product2.save

      expect(product2).not_to be_valid
    end
  end

  # context 'Quantity' do
  #   it 'can not be negative' do
  #     warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
  #     address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
  #     total_area: 5000, useful_area: 4000)
  #     supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
  #       cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
  #     category = ProductCategory.create!(name: 'Eletrônicos Potentes')
  #     product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, 
  #                         product_category: category, weight: 200, width: 30, height: 5, length: 12)
  #     pi = ProductItem.create!(warehouse: warehouse, product_model: product)
  #     allow(ProductItem).to receive(:quantity).with(-2)

  #     expect(pi).not_to be_valid
  #   end
  # end
end
