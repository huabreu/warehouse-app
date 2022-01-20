require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  context 'All fields are mandatory' do
    it 'Supplier is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567812334', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: nil, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Name is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: '', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Weight is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: '', width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Width is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: '', height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Height is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: '', length: 12)

      expect(product).not_to be_valid
    end

    it 'Length is mandatory' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: '')

      expect(product).not_to be_valid
    end
  end

  context 'Weight must be greater than zero' do
    it 'Weight is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: -200, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Weight is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 0, width: 30, height: 5, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Width must be greater than zero' do
    it 'Width is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: -30, height: 5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Width is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 0, height: 5, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Height must be greater than zero' do
    it 'Height is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: -5, length: 12)

      expect(product).not_to be_valid
    end

    it 'Height is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 0, length: 12)

      expect(product).not_to be_valid
    end
  end

  context 'Length must be greater than zero' do
    it 'Length is negative' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: -12)

      expect(product).not_to be_valid
    end

    it 'Length is zero' do
      supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                  cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
      product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD313',
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
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier,
                                   product_category: category, weight: 200, width: 30, height: 5, length: 12)

    expect(product.sku_code).not_to eq nil
  end

  it 'SKU must have 20 characters' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier,
                                   product_category: category, weight: 200, width: 30, height: 5, length: 12)

    expect(product.sku_code.length).to be_equal 20
  end

  it 'SKU must be random' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product = ProductModel.new(name: 'Teclado Digitador', supplier: supplier,
                               product_category: category, weight: 200, width: 30, height: 5, length: 12)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6BH0esFqq9gQaDGrYBjV'

    product.save

    expect(product.sku_code).to eq '6BH0esFqq9gQaDGrYBjV'
  end

  it 'SKU must not change after an update' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier,
                                   product_category: category, weight: 200, width: 30, height: 5, length: 12)
    sku = product.sku_code

    product.update(name: 'Teclado Macio')

    expect(product.name).to eq 'Teclado Macio'
    expect(product.sku_code).to eq sku
  end

  it 'SKU must be unique' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                cnpj: '1234567891234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product1 = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier,
                                    product_category: category, weight: 200, width: 30, height: 5, length: 12)
    sku = product1.sku_code

    product2 = ProductModel.new(name: 'Som Bacana', supplier: supplier,
                                weight: 400, width: 30, height: 32, length: 12)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return sku
    product2.save

    expect(product2).not_to be_valid
  end
end
