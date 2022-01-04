require 'rails_helper'

describe 'User register product model' do
  it 'visitor is unable to access the form' do
    #act
    visit new_product_model_path
    #assert
    expect(current_path).to eq  new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through a link on the homepage' do
    #arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo produto'

    expect(page).to have_content 'Novo Produto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Fornecedor'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Comprimento'
    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    #arrange
    Supplier.create!(trade_name: 'Ceramicas Geek', company_name: 'Ceramicas Geeks SA', 
                     cnpj: 1234567891123, email: 'ceramicgeek@gmaial.com')
    Supplier.create!(trade_name: 'Imaginarium', company_name: 'Imaginarium SA', 
    cnpj: 1234547891123, email: 'imaginarium@gmaial.com')

    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: '300'
    fill_in 'Altura', with: 12
    fill_in 'Largura', with: 8
    fill_in 'Comprimento', with: 14
    select 'Ceramicas Geek', from: 'Fornecedor'

    click_on 'Salvar'

    #assert
    p = ProductModel.last
    expect(page).to have_content 'Produto cadastrado com sucesso!'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 g'
    expect(page).to have_content 'Largura: 8 cm'
    expect(page).to have_content 'Altura: 12 cm'
    expect(page).to have_content 'Comprimento: 14 cm'
    expect(page).to have_content "SKU: #{p.sku_code}"
    expect(page).to have_content 'Fornecedor: Ceramicas Geek'
  end

  it 'without success' do
    #arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit new_product_model_path
    click_on 'Salvar'
  
    expect(page).not_to have_content('Produto cadastrado com sucesso!')
    expect(page).to have_content('Erro! Não foi possível cadastrar o produto!')
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Peso não pode ficar em branco")
    expect(page).to have_content("Altura não pode ficar em branco")
    expect(page).to have_content("Largura não pode ficar em branco")
    expect(page).to have_content("Comprimento não pode ficar em branco")
    expect(page).to have_content("Fornecedor é obrigatório(a)")
  end
end

