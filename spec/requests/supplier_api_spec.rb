require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'successfully' do
      # arrange
      Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
      # act
      get '/api/v1/suppliers'
      # assert
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["trade_name"]).to eq 'Fornecedor Bonito'
      expect(parsed_response[1]["trade_name"]).to eq 'Ipiranga Logisticas'
      expect(parsed_response[0]["company_name"]).to eq 'Fornecedor Bonito e Formoso SA'
      expect(parsed_response[1]["company_name"]).to eq 'Ipiranga Logisticas SA'
      expect(response.body[1]).not_to include "updated_at"
      expect(response.body[1]).not_to include "created_at"
      expect(response.body[0]).not_to include "updated_at"
      expect(response.body[0]).not_to include "created_at"
    end

    it 'empty response' do
      #arrange

      #act
      get '/api/v1/suppliers'
      #assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'successfully' do
      s = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')

      get "/api/v1/suppliers/#{s.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response["trade_name"]).to eq 'Fornecedor Bonito'
      expect(parsed_response["company_name"]).to eq 'Fornecedor Bonito e Formoso SA'
      expect(parsed_response["cnpj"]).to eq '1234567891234'
      expect(parsed_response["address"]).to eq 'Rua Formosa'
      expect(parsed_response["email"]).to eq 'fbonito@hotmail.com'
      expect(parsed_response["phone"]).to eq '32156589'
      expect(parsed_response.keys).not_to include "created_at"
      expect(parsed_response.keys).not_to include "updated_at"
    end

  #   it 'warehouse do not exist' do
  #     get "/api/v1/warehouses/9999"

  #     expect(response.status).to eq 404
  #   end
  end
end