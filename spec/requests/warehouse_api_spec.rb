require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'successfully' do
      # arrange
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima', zip_code: '57050-000', 
                      city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Juiz de Fora', code: 'JDF', description: 'Ótimo galpão a beira mar',
                      address: 'Av. Rio Branco', zip_code: '36050-000', 
                      city: 'Juiz de Fora', state: 'MG', total_area: 20000, useful_area: 13000)
      # act
      get '/api/v1/warehouses'
      # assert
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Maceió'
      expect(parsed_response[1]["name"]).to eq 'Juiz de Fora'
      expect(response.body[1]).not_to include "updated_at"
      expect(response.body[1]).not_to include "created_at"
      expect(response.body[0]).not_to include "updated_at"
      expect(response.body[0]).not_to include "created_at"
    end

    it 'empty response' do
      #arrange

      #act
      get '/api/v1/warehouses'
      #assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'successfully' do
      warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima', zip_code: '57050-000', 
                      city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)
      Warehouse.create!(name: 'Juiz de Fora', code: 'JDF', description: 'Ótimo galpão a beira mar',
                      address: 'Av. Rio Branco', zip_code: '36050-000', 
                      city: 'Juiz de Fora', state: 'MG', total_area: 20000, useful_area: 13000)

      get "/api/v1/warehouses/#{warehouse.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response["name"]).to eq 'Maceió'
      expect(parsed_response["code"]).to eq 'MCZ'
      expect(parsed_response["description"]).to eq 'Ótimo galpão no centro da cidade'
      expect(parsed_response["address"]).to eq 'Av. Fernandes Lima'
      expect(parsed_response["zip_code"]).to eq '57050-000'
      expect(parsed_response["city"]).to eq 'Maceió'
      expect(parsed_response["state"]).to eq 'AL'
      expect(parsed_response.keys).not_to include "created_at"
      expect(parsed_response.keys).not_to include "updated_at"
    end

    it 'warehouse do not exist' do
      get "/api/v1/warehouses/9999"

      expect(response.status).to eq 404
    end
  end
end