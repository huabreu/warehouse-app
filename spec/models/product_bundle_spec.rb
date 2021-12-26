require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  it 'Name is mandatory' do
    # supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    # cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    # ProductModel.create!(name:'Caixas de Som Blast', supplier: supplier, sku_code: 'CSXBB12321IPLO202111',
    # weight: 200, width: 30, height: 15, length: 12)
    # ProductModel.create!(name:'Som Muito Alto', supplier: supplier, sku_code: 'SMMAL12321IPLO202111',
    # weight: 500, width: 30, height: 20, length: 12)
    bundle = ProductBundle.new(name: '', sku_code: 'KSUMEBU25122021123456')

    expect(bundle).not_to be_valid
  end

  context 'SKU code must have 21 digits and start with the letter K' do
    it 'SKU equal to KABCDEFGHIJ123456789' do
      bundle = ProductBundle.new(name: 'Super Mega Bundle', sku_code: 'KABCDEFGHIJ123456789')

      expect(bundle).not_to be_valid
    end

    it 'SKU equal to KABCDEFGHIJ12345678901' do
      bundle = ProductBundle.new(name: 'Super Mega Bundle', sku_code: 'KABCDEFGHIJ12345678901')

      expect(bundle).not_to be_valid
    end

    it 'SKU equal to SABCDEFGHIJ1234567890' do
      bundle = ProductBundle.new(name: 'Super Mega Bundle', sku_code: 'SABCDEFGHIJ1234567890')

      expect(bundle).not_to be_valid
    end
  end

end
