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
      ProductModel.create!(name: 'Teclado Digitador', supplier: s1, product_category: category,
                           weight: 200, width: 30, height: 5, length: 12)
      ProductModel.create!(name: 'Cuecas Descartáveis', supplier: s2, product_category: category,
                           weight: 200, width: 30, height: 5, length: 12)
      # act
      get '/api/v1/product_models'
      # assert
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['name']).to eq 'Teclado Digitador'
      expect(parsed_response[0]['supplier_id']).to eq s1.id
      expect(parsed_response[0]['product_category_id']).to eq category.id
      expect(parsed_response[0]['weight']).to eq 200
      expect(parsed_response[0]['dimensions']).to eq '5 x 30 x 12'
      expect(parsed_response[1]['name']).to eq 'Cuecas Descartáveis'
      expect(parsed_response[1]['supplier_id']).to eq s2.id
      expect(parsed_response[1]['product_category_id']).to eq category.id
      expect(parsed_response[0]['weight']).to eq 200
      expect(parsed_response[1]['dimensions']).to eq '5 x 30 x 12'
      expect(response.body[1]).not_to include 'updated_at'
      expect(response.body[1]).not_to include 'created_at'
      expect(response.body[0]).not_to include 'updated_at'
      expect(response.body[0]).not_to include 'created_at'
    end

    it 'empty response' do
      # arrange

      # act
      get '/api/v1/product_models'
      # assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_models/:id' do
    it 'successfully - 200' do
      category = ProductCategory.create!(name: 'Laticínios')
      s = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                           cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: category,
                                weight: 200, width: 30, height: 5, length: 12)

      get "/api/v1/product_models/#{pm.id}"

      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['name']).to eq 'Teclado Digitador'
      expect(parsed_response['weight']).to eq 200
      expect(parsed_response['width']).to eq 30
      expect(parsed_response['height']).to eq 5
      expect(parsed_response['length']).to eq 12
      expect(parsed_response['supplier']['trade_name']).to eq 'Fornecedor Bonito'
      expect(parsed_response['supplier']['company_name']).to eq 'Fornecedor Bonito e Formoso SA'
      expect(parsed_response['supplier']['cnpj']).to eq '1234567891234'
      expect(parsed_response['supplier']['address']).to eq 'Rua Formosa'
      expect(parsed_response['supplier']['email']).to eq 'fbonito@hotmail.com'
      expect(parsed_response['supplier']['phone']).to eq '32156589'
      expect(parsed_response['product_category']['name']).to eq 'Laticínios'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
      expect(parsed_response.keys).not_to include 'supplier_id'
      expect(parsed_response.keys).not_to include 'product_category_id'
    end

    it 'product model not found - 404' do
      get '/api/v1/product_models/9999'

      expect(response.status).to eq 404
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto não encontrado'
    end

    it 'invalid parameter - 412' do
      allow(ProductModel).to receive(:find).with(-1.to_s).and_raise ActiveRecord::StatementInvalid

      get '/api/v1/product_models/-1'

      expect(response.status).to eq 412
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Parâmetro inválido'
    end

    it 'database error - 500' do
      c = ProductCategory.create!(name: 'Laticínios')
      s = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                           cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: c,
                                weight: 200, width: 30, height: 5, length: 12)
      allow(ProductModel).to receive(:find).with(pm.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished

      get "/api/v1/product_models/#{pm.id}"

      expect(response.status).to eq 500
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro ao estabelecer uma conexão com o banco de dados'
    end
  end

  context 'POST /api/v1/product_models' do
    it 'successfully' do
      # arrange
      ProductCategory.create!(name: 'Laticínios')
      Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                       cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      # act
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/product_models', params: '{ "name": "Ovo Gigante",
                                                "weight": 17,
                                                "height": "1",
                                                "width": 1,
                                                "length": 1,
                                                "supplier_id": 1,
                                                "product_category_id": 1
                                                }',
                                     headers: headers
      # assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Ovo Gigante'
      expect(parsed_response['weight']).to eq 17
      expect(parsed_response['height']).to eq 1
      expect(parsed_response['width']).to eq 1
      expect(parsed_response['length']).to eq 1
      expect(parsed_response['supplier_id']).to eq 1
      expect(parsed_response['product_category_id']).to eq 1
      expect(parsed_response['id']).to be_a_kind_of(Integer)
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'has mandatory fields' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/product_models', params: '{ }',
                                     headers: headers

      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
      expect(response.body).to include 'Fornecedor é obrigatório(a)'
      expect(response.body).to include 'Categoria é obrigatório(a)'
      expect(response.body).to include 'Peso não pode ficar em branco'
      expect(response.body).to include 'Altura não pode ficar em branco'
      expect(response.body).to include 'Largura não pode ficar em branco'
      expect(response.body).to include 'Comprimento não pode ficar em branco'
    end

    it 'database error - 500' do
      allow(ProductModel).to receive(:new).and_raise ActiveRecord::ConnectionNotEstablished

      ProductCategory.create!(name: 'Laticínios')
      Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                       cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/product_models', params: '{ "name": "Ovo Gigante",
                                                "weight": 17,
                                                "height": "1",
                                                "width": 1,
                                                "length": 1,

                                                "product_category_id": 1
                                                }',
                                     headers: headers

      expect(response.status).to eq 500
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Erro ao estabelecer uma conexão com o banco de dados'
    end
  end
end
