require 'rails_helper'

describe 'User register new product category' do
  it 'visitor is unable to access the form' do
    visit new_product_category_path
    
    expect(current_path).to eq  new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through a link on the homepage' do
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as user
    visit root_path
    click_on 'Cadastrar nova categoria de produtos'

    expect(page).to have_css 'h1', text: 'Nova Categoria de Produtos'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as user
    visit new_product_category_path
    fill_in 'Nome', with: 'Eletrônicos Potentes'
    click_on 'Salvar'

    expect(page).to have_content 'Categoria cadastrada com sucesso!'
    expect(page).to have_content 'Eletrônicos Potentes'
  end

  it 'without success' do
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as user
    visit new_product_category_path
    click_on 'Salvar'

    expect(page).not_to have_content('Categoria cadastrada com sucesso!')
    expect(page).to have_content('Erro! Não foi possível cadastrar a nova categoria!')
    expect(page).to have_content("Nome não pode ficar em branco")
  end
end