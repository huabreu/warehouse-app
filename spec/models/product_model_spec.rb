require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  context 'All fields are mandatory' do
    it 'Supplier is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567812334', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: nil, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Name is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end


    it 'Weight is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: '', width: 30, height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Width is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: '', height: 5, length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Height is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: '', length: 12)
    
      expect(product).not_to be_valid
    end

    it 'Length is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                 cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: '')
    
      expect(product).not_to be_valid
    end
  end

  context 'Weight must be greater than zero' do
    it 'Weight is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: -200, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Weight is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 0, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Width must be greater than zero' do
    it 'Width is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 200, width: -30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Width is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 200, width: 0, height: 5, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Height must be greater than zero' do
    it 'Height is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 200, width: 30, height: -5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Height is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 200, width: 30, height: 0, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Length must be greater than zero' do
    it 'Length is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                  weight: 200, width: 30, height: 5, length: -12)

      expect(product).not_to be_valid
    end

    it 'Length is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD313',
                                  weight: 200, width: 30, height: 5, length: 0)

      expect(product).not_to be_valid
    end
  end

  it '.dimension' do
    p = ProductModel.new(height: 12, width: 5, length: 30)

    expect(p.dimensions).to eq '12 x 5 x 30'
  end

  it 'SKU must be auto generated' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier,
      weight: 200, width: 30, height: 5, length: 12)

    expect(product.sku_code).not_to be_empty
  end

  it 'SKU must have 20 characters' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier,
      weight: 200, width: 30, height: 5, length: 12)

    expect(product.sku_code.length).to be_equal 20
  end

  context 'SKU must be unique' do
    it 'SKU is duplicate' do 
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
        cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier,
        weight: 200, width: 30, height: 5, length: 12)
      product2 = ProductModel.new(name:'Teclado Digitador', supplier: supplier,
        weight: 200, width: 30, height: 5, length: 12, sku_code: product1.sku_code)

      expect(product2).not_to be_valid
    end

    it 'two products are created' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier,
        weight: 200, width: 30, height: 5, length: 12)
      product2 = ProductModel.new(name:'Teclado Digitador', supplier: supplier,
        weight: 200, width: 30, height: 5, length: 12)

    expect(product1.sku_code).not_to be_equal product2.sku_code
    end
  end
  # it 'SKU must have 20 characters' do
  #   it 'SKU has less than 20 characteres' do
  #     supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
  #     cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
  #     product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD221212322ASD231',
  #     weight: 200, width: 30, height: 5, length: 12)
      
  #     expect(product).not_to be_valid
  #   end

  #   it 'SKU has more than 20 characteres' do
  #     supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
  #     cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
  #     product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDDa2221212322ASD231',
  #     weight: 200, width: 30, height: 5, length: 12)
      
  #     expect(product).not_to be_valid
  #   end

  #   it 'SKU has more than 20 characteres' do
  #     supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
  #     cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
  #     product = ProductModel.new(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDDa2221212322ASD231',
  #     weight: 200, width: 30, height: 5, length: 12)
      
  #     expect(product).not_to be_valid
  #   end

  # end
  # it 'sku code must be generated automatic' do
  #   supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
  #   cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
  #   product = ProductModel.new(name:'Teclado Digitador', supplier: supplier,
  #   weight: 200, width: 30, height: 0, length: 12)

  #   expect(product.sku_code).not_to be_nil 
  # end
end
