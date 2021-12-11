require 'rails_helper'

describe 'visitor view homepage' do
  it 'view welcome message' do
    visit root_path

    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'view registered warehouses' do
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                     address: 'Av. Fernandes Lima', zip_code: '57050-000', 
                     city: 'Maceió', state: 'AL', 
                     total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Juiz de Fora', code: 'JDF', description: 'Ótimo galpão a beira mar',
                     address: 'Av. Rio Branco', zip_code: '36050-000', 
                     city: 'Juiz de Fora', state: 'MG', 
                     total_area: 20000, useful_area: 13000)

    visit root_path

    expect(page).to have_css 'h2', text: 'Galpões Cadastrados'
    expect(page).to have_content 'Maceió'
    expect(page).to have_content 'MCZ'
    expect(page).to have_content 'Juiz de Fora'
    expect(page).to have_content 'JDF'

  end

  it 'do not see all warehouses details' do
    # Arrange
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     zip_code: '57050-000',
                     total_area: 10000, useful_area: 8000)
    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content('Ótimo galpão numa linda cidade')
    expect(page).not_to have_content('Av Fernandes Lima')
    expect(page).not_to have_content('Maceió/AL')
    expect(page).not_to have_content('57050-000')
  end
end