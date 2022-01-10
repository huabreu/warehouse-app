require 'rails_helper'

describe 'Product Model API' do
  context 'GET /api/v1/product_models' do
    it 'successfully' do
      # arrange
      category = ProductCategory.create!(name: 'Laticínios')
      s1 = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      s2 = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
      ProductModel.create!(name:'Teclado Digitador', supplier: s1, product_category: category,
      weight: 200, width: 30, height: 5, length: 12)
      ProductModel.create!(name:'Cuecas Descartáveis', supplier: s2, product_category: category,
      weight: 200, width: 30, height: 5, length: 12) 
      # act
      get '/api/v1/product_models'
      # assert
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]["name"]).to eq 'Teclado Digitador'
      expect(parsed_response[0]["supplier_id"]).to eq s1.id
      expect(parsed_response[0]["product_category_id"]).to eq category.id
      expect(parsed_response[0]["weight"]).to eq 200
      expect(parsed_response[0]["width"]).to eq 30
      expect(parsed_response[0]["height"]).to eq 5
      expect(parsed_response[0]["length"]).to eq 12
      expect(parsed_response[1]["name"]).to eq 'Cuecas Descartáveis'
      expect(parsed_response[1]["supplier_id"]).to eq s2.id
      expect(parsed_response[1]["product_category_id"]).to eq category.id
      expect(parsed_response[0]["weight"]).to eq 200
      expect(parsed_response[0]["width"]).to eq 30
      expect(parsed_response[0]["height"]).to eq 5
      expect(parsed_response[0]["length"]).to eq 12
      expect(response.body[1]).not_to include "updated_at"
      expect(response.body[1]).not_to include "created_at"
      expect(response.body[0]).not_to include "updated_at"
      expect(response.body[0]).not_to include "created_at"
    end

    it 'empty response' do
      #arrange

      #act
      get '/api/v1/product_models'
      #assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_models/:id' do
    it 'successfully' do
      category = ProductCategory.create!(name: 'Laticínios')
      s1 = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
      cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      s2 = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
      cnpj: '1234567811234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
      pm = ProductModel.create!(name:'Teclado Digitador', supplier: s1, product_category: category,
      weight: 200, width: 30, height: 5, length: 12)
      ProductModel.create!(name:'Cuecas Descartáveis', supplier: s2, product_category: category,
      weight: 200, width: 30, height: 5, length: 12)

      get "/api/v1/product_models/#{pm.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response["name"]).to eq 'Teclado Digitador'
      expect(parsed_response["supplier_id"]).to eq s1.id
      expect(parsed_response["product_category_id"]).to eq category.id
      expect(parsed_response["weight"]).to eq 200
      expect(parsed_response["width"]).to eq 30
      expect(parsed_response["height"]).to eq 5
      expect(parsed_response["length"]).to eq 12
      expect(parsed_response.keys).not_to include "created_at"
      expect(parsed_response.keys).not_to include "updated_at"
    end

    it 'product models do not exist' do
      get "/api/v1/product_models/9999"

      expect(response.status).to eq 404
    end
  end
end