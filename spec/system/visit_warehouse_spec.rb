require 'rails_helper'

describe 'visitor view a warehouse' do
  it 'and see all registered data' do
    # arrange
    Warehouse.create!(name: 'Maceió',
                      code: 'MCZ',
                      description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima',
                      zip_code: '57050-000',
                      city: 'Maceió',
                      state: 'AL',
                      total_area: 10_000,
                      useful_area: 8_000)
    # act
    visit root_path
    click_on 'Maceió'
    # assert
    expect(page).to have_content('Maceió')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('Ótimo galpão no centro da cidade')
    expect(page).to have_content('Av. Fernandes Lima')
    expect(page).to have_content('CEP: 57050-000')
    expect(page).to have_content('Maceió/AL')
    expect(page).to have_content('Área Total: 10000 m2')
    expect(page).to have_content('Área Útil: 8000 m2')
    expect(page).to have_link('Excluir')
    expect(page).to have_link('Voltar', href: root_path)
  end

  it 'and comeback to homepage' do
    # Arrange
    Warehouse.create!(name: 'Maceió',
                      code: 'MCZ',
                      description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima',
                      city: 'Maceió',
                      state: 'AL',
                      zip_code: '57050-000',
                      total_area: 10_000,
                      useful_area: 8_000)
    # Act
    visit root_path
    click_on 'Maceió'
    click_on 'Voltar'
    # Assert
    expect(current_path).to eq root_path
  end
end
