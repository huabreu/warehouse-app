require 'rails_helper'

describe 'Supplier API' do
  context 'GET /api/v1/suppliers' do
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

    it 'supplier do not exist' do
      get "/api/v1/suppliers/9999"

      expect(response.status).to eq 404
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto não encontrado'
    end
  end

  context 'POST /api/v1/suppliers' do
    it 'successfully' do
      # arrange

      # act
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "trade_name": "Pinguitinga Express",
                                           "company_name": "Pinguitinga Express SA",
                                           "cnpj": "1222267891234",
                                           "address": "Avenida dos Galpões, 1000",
                                           "email": "pinquix@gmail.com",
                                           "phone": "3433984521" }',
                                  headers: headers
      # assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["trade_name"]).to eq 'Pinguitinga Express'
      expect(parsed_response["company_name"]).to eq 'Pinguitinga Express SA'
      expect(parsed_response["cnpj"]).to eq '1222267891234'
      expect(parsed_response["address"]).to eq 'Avenida dos Galpões, 1000'
      expect(parsed_response["email"]).to eq 'pinquix@gmail.com'
      expect(parsed_response["phone"]).to eq '3433984521'
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response.keys).not_to include "created_at"
      expect(parsed_response.keys).not_to include "updated_at"
    end

    it 'has mandatory fields' do
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ }',
                                 headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include "Nome Fantasia não pode ficar em branco"
      expect(response.body).to include "Razão Social não pode ficar em branco"
      expect(response.body).to include "CNPJ não pode ficar em branco"
      expect(response.body).to include "E-mail não pode ficar em branco"
    end

    it 'cnpj is not unique' do
      Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1222267891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "trade_name": "Pinguitinga Express",
                                           "company_name": "Pinguitinga Express SA",
                                           "cnpj": "1222267891234",
                                           "address": "Avenida dos Galpões, 1000",
                                           "email": "pinquix@gmail.com",
                                           "phone": "3433984521" }',
                                  headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include "CNPJ já está em uso"
    end

    it 'database error - 500' do
      allow(Supplier).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/suppliers', params: '{ "trade_name": "Pinguitinga Express",
                                           "company_name": "Pinguitinga Express SA",
                                           "cnpj": "1222267891234",
                                           "address": "Avenida dos Galpões, 1000",
                                           "email": "pinquix@gmail.com",
                                           "phone": "3433984521" }',
                                  headers: headers

      expect(response.status).to eq 500
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Erro ao estabelecer uma conexão com o banco de dados'
    end
  end
end