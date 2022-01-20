require 'rails_helper'

describe 'User deletes a warehouse' do
  it 'visitor is unable to' do
    # arrange
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000',
                                  city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    # act
    visit warehouse_path(warehouse.id)
    click_on 'Excluir'
    # assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'with success', js: true do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Excluir'

    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão excluído com sucesso!')
    expect(page).not_to have_content('Maceió')
    expect(page).not_to have_content('MCZ')
  end

  # it 'without success' do
  #   warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
  #   address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
  #   total_area: 10000, useful_area: 8000)
  #   user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')

  #   login_as(user)
  #   visit root_path
  #   click_on 'Maceió'
  #   # click_on 'Excluir'
  #   allow(Warehouse).to receive(:destroy).and_return(false)

  #   expect(current_path).to eq warehouse_path(warehouse.id)
  #   expect(page).not_to have_content('Erro! Não foi possível excluír o galpão!')
  #   expect(page).to have_content('Maceió')
  #   expect(page).to have_content('MDZ')
  #   expect(page).not_to have_content('Galpão excluído com sucesso!')
  # end
end
