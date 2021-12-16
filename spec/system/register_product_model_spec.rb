require 'rails_helper'

describe 'User register product model' do
  it 'through a link on the homepage' do

    visit root_path
    click_on 'Cadastrar novo produto'

    expect(page).to have_content 'Novo Produto'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Fornecedor'
    expect(page).to have_field 'Peso(g)'
    expect(page).to have_field 'Altura(cm)'
    expect(page).to have_field 'Largura(cm)'
    expect(page).to have_field 'Comprimento(cm)'
    expect(page).to have_field 'Código SKU'
    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    #arrange
    Supplier.create!(trade_name: 'Ceramicas Geek', company_name: 'Ceramicas Geeks SA', 
                     cnpj: 1234567891123, email: 'ceramicgeek@gmaial.com')
    Supplier.create!(trade_name: 'Imaginarium', company_name: 'Imaginarium SA', 
    cnpj: 1234547891123, email: 'imaginarium@gmaial.com')

    #act
    visit root_path
    click_on 'Cadastrar novo produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso(g)', with: '300'
    fill_in 'Altura(cm)', with: 12
    fill_in 'Largura(cm)', with: 8
    fill_in 'Comprimento(cm)', with: 14
    fill_in 'Código SKU', with: 'CNSW2020123456789112'
    select 'Ceramicas Geek', from: 'Fornecedor'

    click_on 'Salvar'

    #assert
    expect(page).to have_content 'Produto cadastrado com sucesso!'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300g'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14' 
    expect(page).to have_content 'SKU: CNSW2020123456789112'
    expect(page).to have_content 'Fornecedor: Ceramicas Geek'
  end

  it 'without success' do

    visit root_path
    click_on 'Cadastrar novo produto'
    click_on 'Salvar'
  
    expect(page).not_to have_content('Produto cadastrado com sucesso!')
    expect(page).to have_content('Erro! Não foi possível cadastrar o produto!')
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Peso não pode ficar em branco")
    expect(page).to have_content("Altura não pode ficar em branco")
    expect(page).to have_content("Largura não pode ficar em branco")
    expect(page).to have_content("Comprimento não pode ficar em branco")
    expect(page).to have_content("Código SKU não pode ficar em branco")
    # expect(page).to have_content("FOrnecedor não pode ficar em branco")
  end
end

