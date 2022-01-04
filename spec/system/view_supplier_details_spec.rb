require 'rails_helper'

describe 'User view supplier details' do
  it 'with success' do
    Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1294567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')

    visit suppliers_path
    click_on 'Ipiranga Logisticas'

    expect(page).to have_content 'Ipiranga Logisticas'
    expect(page).to have_content 'Ipiranga Logisticas SA'
    expect(page).to have_content '1294567811234'
    expect(page).to have_content 'Av. Don Pedro II'
    expect(page).to have_content 'iippiiranga@hotmail.com'
    expect(page).to have_content '345896654'
  end

  it 'and view the supplier`s products' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
    other_supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')

    p1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, sku_code: 'TCDD2123212322ASD231',
      weight: 200, width: 30, height: 5, length: 12)
    p2 = ProductModel.create!(name:'Som Muito Alto', supplier: supplier, sku_code: 'SMAA2123212322ASD231',
    weight: 500, width: 30, height: 20, length: 12)
    p3 = ProductModel.create!(name:'Som Muito Baixo', supplier: other_supplier, sku_code: 'SMAB2123212322ASD231',
    weight: 500, width: 30, height: 20, length: 12)

    visit suppliers_path
    click_on 'Ipiranga Logisticas'

    expect(page).to have_css 'h1', text:'Ipiranga Logisticas'
    expect(page).to have_css 'h3', text:'Produtos Cadastrados:'
    expect(page).to have_content 'Teclado Digitador'
    expect(page).to have_content p1.sku_code
    expect(page).to have_content 'Som Muito Alto'
    expect(page).to have_content p2.sku_code
    expect(page).not_to have_content 'Som Muito Baixo'
    expect(page).not_to have_content p3.sku_code
    end
end