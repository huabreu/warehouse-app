require 'rails_helper'

describe 'Visitor view product model details' do
  it 'with success' do
    supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                                cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    category = ProductCategory.create!(name: 'Super Produtos')
    warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                  address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                  total_area: 10_000, useful_area: 8000)
    pm = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                              weight: 200, width: 30, height: 5, length: 12)
    ProductItem.create!(warehouse: warehouse, product_model: pm)

    visit product_models_path
    click_on 'Teclado Digitador'

    expect(page).to have_content 'Teclado Digitador'
    expect(page).to have_content 'Categoria: Super Produtos'
    expect(page).to have_content 'Fornecedor: Fornecedor Bonito'
    expect(page).to have_content "SKU: #{pm.sku_code}"
    expect(page).to have_content 'Peso: 200 g'
    expect(page).to have_content 'Largura: 30 cm'
    expect(page).to have_content 'Altura: 5 cm'
    expect(page).to have_content 'Comprimento: 12 cm'
  end

  context 'and view registered product items' do
    it 'with success' do
      supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                                  cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
      category = ProductCategory.create!(name: 'Super Produtos')
      warehouse1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                                     address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                                     total_area: 10_000, useful_area: 8000)
      warehouse2 = Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
                                     address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
                                     total_area: 5000, useful_area: 4000)
      product_model1 = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                                            weight: 200, width: 30, height: 5, length: 12)
      product_model2 = ProductModel.create!(name: 'Cuecas Descartáveis', supplier: supplier, product_category: category,
                                            weight: 200, width: 30, height: 5, length: 12)
      10.times do
        ProductItem.create!(warehouse: warehouse1,
                            product_model: product_model1)
      end
      20.times do
        ProductItem.create!(warehouse: warehouse2,
                            product_model: product_model1)
      end
      2.times do
        ProductItem.create!(warehouse: warehouse2,
                            product_model: product_model2)
      end

      visit product_models_path
      click_on 'Teclado Digitador'

      expect(current_path).to eq product_model_path(product_model1.id)
      expect(page).to have_css('h2', text: 'Itens')
      within "div#warehouse-#{warehouse1.id}" do
        # expect(page).to have_css('h3', text: 'Estoque')
        expect(page).to have_content 'Galpão: Maceió'
        expect(page).to have_content 'Quantidade: 10'
      end
      within "div#warehouse-#{warehouse2.id}" do
        # expect(page).to have_css('h3', text: 'Estoque')
        expect(page).to have_content 'Galpão: Curitiba'
        expect(page).to have_content 'Quantidade: 20'
      end
    end

    # it 'but there is no product items registered yet' do
    #   supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
    #   cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    #   category = ProductCategory.create!(name: 'Super Produtos')
    #   warehouse1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
    #   address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
    #   total_area: 10000, useful_area: 8000)
    #   warehouse2 =  Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
    #   address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
    #   total_area: 5000, useful_area: 4000)
    #   product_model1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier, product_category: category,
    #                                weight: 200, width: 30, height: 5, length: 12)
    #   product_model2 = ProductModel.create!(name:'Cuecas Descartáveis', supplier: supplier, product_category: category,
    #   weight: 200, width: 30, height: 5, length: 12)

    #   visit product_models_path
    #   click_on 'Teclado Digitador'

    #   expect(current_path).to eq product_model_path(product_model1.id)
    #   expect(page).to have_css('h2', text: 'Itens')
    #   expect(page).to have_content 'Não existem itens desse modelo em nenhum galpão no momento'
    # end
  end

  context 'Product is activate' do
    it 'visitor is unable to deactivate product model' do
      supplier = create(:supplier)
      category = ProductCategory.create!(name: 'Super Produtos')
      warehouse = create(:warehouse)
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                                weight: 200, width: 30, height: 5, length: 12)

      visit product_model_path(pm.id)

      expect(page).to have_css('h1', text: 'Teclado Digitador')
      expect(page).not_to have_button 'Desativar'
      expect(page).to have_content 'Status: active'
    end

    it 'user deactivate product with success' do
      supplier = create(:supplier)
      category = ProductCategory.create!(name: 'Super Produtos')
      warehouse = create(:warehouse)
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                                weight: 200, width: 30, height: 5, length: 12)
      user = create(:user)

      login_as user
      visit product_model_path(pm.id)
      click_on 'Desativar'

      expect(current_path).to eq product_model_path(pm.id)
      expect(page).to have_button 'Ativar'
      expect(page).to have_content 'Status: inactive'
    end
  end

  context 'Product is inactive' do
    it 'visitor is unable to activate product model' do
      supplier = create(:supplier)
      category = ProductCategory.create!(name: 'Super Produtos')
      warehouse = create(:warehouse)
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                                weight: 200, width: 30, height: 5, length: 12)
      pm.inactive!

      visit product_model_path(pm.id)

      expect(page).to have_css('h1', text: 'Teclado Digitador')
      expect(page).not_to have_button 'Ativar'
      expect(page).to have_content 'Status: inactive'
    end

    it 'user activate product with success' do
      supplier = create(:supplier)
      category = ProductCategory.create!(name: 'Super Produtos')
      warehouse = create(:warehouse)
      pm = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: category,
                                weight: 200, width: 30, height: 5, length: 12)
      user = create(:user)
      pm.inactive!

      login_as user
      visit product_model_path(pm.id)
      click_on 'Ativar'

      expect(current_path).to eq product_model_path(pm.id)
      expect(page).to have_button 'Desativar'
      expect(page).to have_content 'Status: active'
    end
  end
end
