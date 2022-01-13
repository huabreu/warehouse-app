require 'rails_helper'

describe 'User deletes a warehouse' do
  it 'visitor is unable to' do
    #arrange
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
    address: 'Av. Fernandes Lima', zip_code: '57050-000', 
    city: 'Maceió', state: 'AL', 
    total_area: 10000, useful_area: 8000)
    #act
    visit warehouse_path(warehouse.id)
    click_on 'Excluir'
    #assert
    expect(current_path).to eq  new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  # it 'throught a link on the warehouse page' do
  #   warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
  #   address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL', 
  #   total_area: 10000, useful_area: 8000)
  #   Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
  #   address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
  #   total_area: 5000, useful_area: 4000)
  #   user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    
  #   login_as(user)
  #   visit root_path
  #   click_on 'Maceió'

  #   expect(page).to have_css 'h1', text: 'Maceió'
  #   expect(page).to have_link 'Excluir'
  # end

  
  it 'with success', js:true do
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
    address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL', 
    total_area: 10000, useful_area: 8000)
    user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
    
    login_as(user)
    visit root_path
    click_on 'Maceió'
    click_on 'Excluir'
    page.evaluate_script('window.confirm = function() { return true; }')

    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão excluído com sucesso!')
    expect(page).not_to have_content('Juiz de Fora')
    expect(page).not_to have_content('JDF')
  end

  # it 'without success' do
  # end
end