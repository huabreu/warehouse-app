require 'rails_helper'

describe 'Visitor searchs warehouse' do
  context 'by its name' do
    it 'with success' do
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
      address: 'Av. Fernandes Lima', zip_code: '57050-000', 
      city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Lomaco', code: 'LMC', description: 'Ótimo galpão a beira mar',
      address: 'Av. Rio Branco', zip_code: '36050-000', 
      city: 'Juiz de Fora', state: 'MG', total_area: 20000, useful_area: 13000)
      Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      visit root_path
      fill_in 'query', with: 'mac'
      click_on 'Pesquisar'

      expect(current_path).to eq search_warehouses_path
      expect(page).to have_css('h1', text: 'Galpões Encontrados')
      expect(page).to have_content('Maceió (MCZ)')
      expect(page).to have_content('Localização: Maceió - AL')
      expect(page).to have_content('Lomaco (LMC)')
      expect(page).to have_content('Localização: Juiz de Fora - MG')
      expect(page).not_to have_content('Curitiba (CTB)')
      expect(page).not_to have_content('Curitiba - PR')
    end

    it 'without success' do 
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
      address: 'Av. Fernandes Lima', zip_code: '57050-000', 
      city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Lomaco', code: 'LMC', description: 'Ótimo galpão a beira mar',
      address: 'Av. Rio Branco', zip_code: '36050-000', 
      city: 'Juiz de Fora', state: 'MG', total_area: 20000, useful_area: 13000)

      visit root_path
      fill_in 'query', with: 'zu'
      click_on 'Pesquisar'

      expect(current_path).to eq search_warehouses_path
      expect(page).to have_css('h1', text: 'Galpões Encontrados')
      expect(page).to have_content('Nenhum resultado encontrado')
      expect(page).not_to have_content('Maceió (MCZ)')
      expect(page).not_to have_content('Localização: Maceió - AL')
      expect(page).not_to have_content('Lomaco (LMC)')
      expect(page).not_to have_content('Localização: Juiz de Fora - MG')
    end
  end
end