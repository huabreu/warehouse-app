require 'rails_helper'

describe 'visitor register warehouse' do
  it 'through a link on the homepage' do
    #arrange

    #act
    visit root_path
    click_on 'Cadastrar um novo galpão'

    #assert
    expect(page).to have_content 'Novo Galpão'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'

    expect(page).to have_button 'Salvar'
  end

  it 'with success' do
    #arrange

    #act
    visit root_path
    click_on 'Cadastrar um novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Descrição', with: 'Lindo galpão a beira mar'
    fill_in 'Endereço', with: 'Av. Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36014-520'
    fill_in 'Área Total', with: '20000'
    fill_in 'Área Útil', with: '15000'
    click_on 'Salvar'
    
    #assert
    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Lindo galpão a beira mar')
    expect(page).to have_content('Av. Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36014-520')
    expect(page).to have_content('Área Total: 20000 m2')
    expect(page).to have_content('Área Útil: 15000 m2')

    expect(page).to have_content('Galpão cadastrado com sucesso!')
  end

  it 'all fields are mandatory' do
    #arrange

    #act
    visit root_path
    click_on 'Cadastrar um novo galpão'
    click_on 'Cadastrar um novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    # fill_in 'Descrição', with: ''
    # fill_in 'Endereço', with: ''
    # fill_in 'Cidade', with: ''
    # fill_in 'Estado', with: ''
    # fill_in 'CEP', with: ''
    # fill_in 'Área Total', with: ''
    # fill_in 'Área Útil', with: ''
    click_on 'Salvar'

    #assert
    expect(page).not_to have_content('Galpão cadastrado com sucesso!')
    # expect(page).to have_content('Erro! Não foi possível salvar o galpão!')
    # expect(page).to have_content('Erro! Nome não preenchido!')
    # expect(page).to have_content('Erro! Código não preenchido!')
    expect(page).to have_content("Name can't be blank")
  end
end