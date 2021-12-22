require 'rails_helper'

describe 'visitor register supplier' do
  it 'visitor do not see the menu' do

    visit root_path

    expect(page).not_to have_link 'Cadastrar novo fornecedor'
  end

  it 'visitor is unable to access the form' do
    #act
    visit new_supplier_path
    #assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through a link on the homepage' do
    #arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_content 'Novo Fornecedor'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Telefone'
    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    #arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'FJF'
    fill_in 'Razão Social', with: 'Fornecedor Juiz Forano'
    fill_in 'CNPJ', with: '2546321475668'
    fill_in 'Endereço', with: 'Av. Rio Branco'
    fill_in 'E-mail', with: 'jfg@gmail.com'
    fill_in 'Telefone', with: '3215-6936'
    click_on 'Salvar'
    
    #assert
    expect(page).to have_content('FJF')
    expect(page).to have_content('Fornecedor Juiz Forano')
    expect(page).to have_content('2546321475668')
    expect(page).to have_content('Av. Rio Branco')
    expect(page).to have_content('jfg@gmail.com')
    expect(page).to have_content('3215-6936')

    expect(page).to have_content('Fornecedor cadastrado com sucesso!')
  end

  it 'without success' do
    #arrange
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    #act
    login_as(user)
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    # fill_in 'Nome Fantasia', with: ''
    # fill_in 'Razão Social', with: ''
    # fill_in 'CNPJ', with: ''
    # fill_in 'Endereço', with: 'Av. Rio Branco'
    # fill_in 'E-mail', with: ''
    # fill_in 'Telefone', with: '3215-6936'
    click_on 'Salvar'

    expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
    expect(page).to have_content('Erro! Não foi possível salvar o fornecedor!')
    expect(page).to have_content("Nome Fantasia não pode ficar em branco")
    expect(page).to have_content("Razão Social não pode ficar em branco")
    expect(page).to have_content("CNPJ não pode ficar em branco")
    expect(page).to have_content("E-mail não pode ficar em branco")
  end

  # it 'but CNPJ must be unique' do

  #   Supplier.create(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
  #                   cnpj: '1234567891234', email: 'fbonito@hotmail.com')

  #   visit root_path
  #   click_on 'Cadastrar novo fornecedor'
  #   fill_in 'Nome Fantasia', with: 'Bola'
  #   fill_in 'Razão Social', with: 'Bola SA'
  #   fill_in 'CNPJ', with: '1234567891234'
  #   fill_in 'Endereço', with: 'Av. Campo de Futebol'
  #   fill_in 'E-mail', with: 'fbonito@hotmail.com'
  #   fill_in 'Telefone', with: '3215-6926'
  #   click_on 'Salvar'

  #   expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
  #   expect(page).to have_content('Erro! Não foi possível salvar o fornecedor!')
  #   expect(page).to have_content("CNPJ já está em uso")
  # end

  # it 'but CNPJ must have 13 digits' do

  #   visit root_path
  #   click_on 'Cadastrar novo fornecedor'
  #   fill_in 'Nome Fantasia', with: 'Bola'
  #   fill_in 'Razão Social', with: 'Bola SA'
  #   fill_in 'CNPJ', with: '123467891234'
  #   fill_in 'Endereço', with: 'Av. Campo de Futebol'
  #   fill_in 'E-mail', with: 'fbonito@hotmail.com'
  #   fill_in 'Telefone', with: '3215-6926'
  #   click_on 'Salvar'

  #   expect(page).not_to have_content('Fornecedor cadastrado com sucesso!')
  #   expect(page).to have_content('Erro! Não foi possível salvar o fornecedor!')
  #   expect(page).to have_content("CNPJ não possui o tamanho esperado (13 caracteres)")
  # end
end