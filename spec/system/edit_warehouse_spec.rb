require 'rails_helper'

describe 'User edit a warehouse' do
  it 'visitor is unable to access the form' do
    # arrange
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000',
                                  city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    # act
    visit edit_warehouse_path(warehouse.id)
    # assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught a link on the warehouse page' do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
                      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
                      total_area: 5000, useful_area: 4000)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
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
    # expect(page).to have_link('Voltar', href: edit_warehouse_path(warehouse.id))
  end

  it 'with success' do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Editar'
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

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Lindo galpão a beira mar')
    expect(page).to have_content('Av. Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36014-520')
    expect(page).to have_content('Área Total: 20000 m2')
    expect(page).to have_content('Área Útil: 15000 m2')
    expect(page).to have_content('Galpão editado com sucesso!')
  end

  it 'without success' do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área Total', with: ''
    fill_in 'Área Útil', with: ''
    click_on 'Salvar'

    expect(page).not_to have_content('Galpão editado com sucesso!')
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_content('Erro! Não foi possível editar o galpão!')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Área Total não pode ficar em branco')
    expect(page).to have_content('Área Útil não pode ficar em branco')
  end
end
