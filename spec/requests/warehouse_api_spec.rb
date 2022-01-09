require 'rails_helper'

describe 'Warehouse API' do
  it 'GET /warehouses' do
    # arrange
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                     address: 'Av. Fernandes Lima', zip_code: '57050-000', 
                     city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)
    Warehouse.create(name: 'Juiz de Fora', code: 'JDF', description: 'Ótimo galpão a beira mar',
                     address: 'Av. Rio Branco', zip_code: '36050-000', 
                     city: 'Juiz de Fora', state: 'MG', total_area: 20000, useful_area: 13000)
    # act
    get '/api/warehouses'

    # assert
    expect(response).to have_http_status(200)
    expect(response.content_type).to include('application/json')
    expect(response.body).to include 'Maceió'
    expect(response.body).to include 'Juiz de Fora'
  end
end