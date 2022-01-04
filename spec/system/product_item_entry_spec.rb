require 'rails_helper'

describe 'User enters new items' do
  it 'with success' do
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
    w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
    address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
    zip_code: '57050-000', total_area: 10000, useful_area: 8000)
    w2 = Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
    address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
    total_area: 5000, useful_area: 4000)
    p1 = ProductModel.create!(name:'Teclado Digitador', supplier: s, sku_code: 'TCDD2123212322ASD231',
                                 weight: 200, width: 30, height: 5, length: 12)
    p2 = ProductModel.create!(name:'Som Muito Alto', supplier: s, sku_code: 'SMAA2123212322ASD231',
                               weight: 500, width: 30, height: 20, length: 12)

    login_as(user)
    visit root_path
    click_on 'Entrada de Itens'
    fill_in 'Quantidade', with: 100
    select 'MCZ', from: 'Galpão Destino'
    select 'Teclado Digitador', from: 'Produto'
    click_on 'Confirmar'

    expect current_path to eq warehouse_path(w1.id)
    within "div#product-#{p1.id}" do
      expect(page).to have_css('h2', text: 'Estoque')
      expect(page).to have_content 'Teclado Digitador'
      expect(page).to have_content 'Quantidade: 100'
    end
  end
end