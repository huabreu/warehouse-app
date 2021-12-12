require 'rails_helper'

describe 'visitor register supplier' do
  it 'through a link on the homepage' do

    visit root_path
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_content 'Novo Fornecedor'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Telefone'

    expect(page).to have_button 'Salvar'
  end
end