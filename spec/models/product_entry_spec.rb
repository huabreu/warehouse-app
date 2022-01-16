# require 'rails_helper'

# context '.process' do
#   it 'but is less than zero' do
#     user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
#     s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
#       cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
#     c = ProductCategory.create!(name: 'Teste')
#     w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
#       address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
#       zip_code: '57050-000', total_area: 10000, useful_area: 8000, product_category_ids: [c.id])
#     pm = ProductModel.create!(name:'Teclado Digitador', supplier: s, product_category: c,
#                               weight: 200, width: 30, height: 5, length: 12)
#     pe = ProductEntry.new(warehouse_id: w.id , product_model_id: pm.id, quantity: -2)

#    expect(pe).not_to be_valid
#   end
# end