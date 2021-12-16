require 'rails_helper'

describe 'visitor visit list of suppliers' do
  it 'and view all registered suppliers' do
    Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
    cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')

    visit root_path
    click_on 'Lista de fornecedores'

    expect(page).to have_css 'h1', text: 'Fornecedores Cadastrados'
    expect(page).to have_content 'Fornecedor Bonito'
    # expect(page).to have_content 'Fornecedor Bonito e Formoso SA'
    # expect(page).to have_content '1234567891234'
    # expect(page).to have_content 'Rua Formosa'
    expect(page).to have_content 'fbonito@hotmail.com'
    expect(page).to have_content '32156589'
    expect(page).to have_content 'Ipiranga Logisticas'
    # expect(page).to have_content 'Ipiranga Logisticas SA'
    # expect(page).to have_content '1234567811234'
    # expect(page).to have_content 'Av. Don Pedro II'
    expect(page).to have_content 'iippiiranga@hotmail.com'
    expect(page).to have_content '345896654'
  end

  it 'but there is no supplier registered yet' do

  visit root_path
  click_on 'Lista de fornecedores'

  expect(page).to have_css 'h1', text: 'Fornecedores Cadastrados'
  expect(page).to have_content 'Não existem fornecedores cadastrados no sistema'
  end
end


