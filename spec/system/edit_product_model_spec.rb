require 'rails_helper'

describe 'User edit a warehouse' do
  it 'visitor is unable to access the form' do
    #arrange
    supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
    cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    product = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)
    #act
    visit edit_product_model_path(product.id)
    #assert
    expect(current_path).to eq  new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught a link on the product model page' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    ProductModel.create!(name:'Teclado Digitador', supplier: supplier, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)
    ProductModel.create!(name:'Som Muito Alto', supplier: supplier, product_category: category,
                               weight: 500, width: 30, height: 20, length: 12)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    
    login_as(user)
    visit root_path
    click_on 'Lista de produtos'
    click_on 'Teclado Digitador'
    click_on 'Editar'

    expect(page).to have_css 'h1', text: 'Editar Produto'
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Peso'
    expect(page).to have_content 'Largura'
    expect(page).to have_content 'Altura'
    expect(page).to have_content 'Comprimento'
    expect(page).to have_content 'Fornecedor'
    expect(page).to have_button 'Salvar'
    # expect(page).to have_link('Voltar', href: edit_warehouse_path(warehouse.id))
  end

  it 'with success' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    ProductModel.create!(name:'Teclado Digitador', supplier: supplier, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    
    login_as(user)
    visit root_path
    click_on 'Lista de produtos'
    click_on 'Teclado Digitador'
    click_on 'Editar'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: '300'
    fill_in 'Altura', with: 12
    fill_in 'Largura', with: 8
    fill_in 'Comprimento', with: 14
    select 'Ipiranga Logisticas', from: 'Fornecedor'
    click_on 'Salvar'
    
    expect(page).to have_content 'Produto editado com sucesso!'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 g'
    expect(page).to have_content 'Largura: 8 cm'
    expect(page).to have_content 'Altura: 12 cm'
    expect(page).to have_content 'Comprimento: 14 cm'
    expect(page).to have_content 'SKU:'
    expect(page).to have_content 'Fornecedor: Ipiranga Logisticas'
  end

  it 'without success' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    ProductModel.create!(name:'Teclado Digitador', supplier: supplier, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    
    login_as(user)
    visit root_path
    click_on 'Lista de produtos'
    click_on 'Teclado Digitador'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Comprimento', with: ''
    click_on 'Salvar'

    expect(page).not_to have_content('Produto editado com sucesso!')
    expect(page).to have_content 'Editar Produto'
    expect(page).to have_content('Erro! Não foi possível editar o produto!')
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Peso não pode ficar em branco")
    expect(page).to have_content("Altura não pode ficar em branco")
    expect(page).to have_content("Largura não pode ficar em branco")
    expect(page).to have_content("Comprimento não pode ficar em branco")
  end
end