require 'rails_helper'

describe 'User register bundle' do
  it 'visitor is unable to access the form' do
    # arrange
    # act
    visit new_product_bundle_path
    # assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through a link on the homepage' do
    # arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    # act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo bundle'

    expect(page).to have_content 'Novo Bundle'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código SKU'
    expect(page).to have_content 'Selecione os produtos desejados'
    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                                cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Eletrônicos Potentes')
    ProductModel.create!(name: 'Caixas de Som Blast', supplier: supplier, product_category: category,
                         weight: 200, width: 30, height: 15, length: 12)
    ProductModel.create!(name: 'Som Muito Alto', supplier: supplier, product_category: category,
                         weight: 500, width: 30, height: 20, length: 12)
    ProductModel.create!(name: 'PC Potente', supplier: supplier, product_category: category,
                         weight: 400, width: 30, height: 10, length: 12)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo bundle'
    fill_in 'Nome', with: 'Bundle Mega Blast Hypersonic'
    fill_in 'Código SKU', with: 'KCMBHY12321IPLO202111'
    check 'Som Muito Alto'
    check 'Caixas de Som Blast'
    click_on 'Salvar'

    expect(page).to have_content 'Bundle cadastrado com sucesso!'
    expect(page).to have_content 'Bundle Mega Blast Hypersonic'
    expect(page).to have_content 'KCMBHY12321IPLO202111'
    expect(page).to have_content 'Som Muito Alto'
    expect(page).to have_content 'Caixas de Som Blast'
    expect(page).not_to have_content 'PC Potente'
  end

  it 'without success' do
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit new_product_bundle_path
    click_on 'Salvar'

    expect(page).not_to have_content('Bundle cadastrado com sucesso!')
    expect(page).to have_content('Erro! Não foi possível cadastrar o bundle!')
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código SKU não pode ficar em branco'
    expect(page).to have_content 'Código SKU deve possuir 21 caracteres e começar com a letra K'
  end
end
