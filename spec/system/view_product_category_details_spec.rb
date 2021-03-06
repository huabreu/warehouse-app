require 'rails_helper'

describe 'Visitor view a specific product category' do
  it 'with success' do
    supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                                cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    c1 = ProductCategory.create!(name: 'Super Produtos')
    c2 = ProductCategory.create!(name: 'Mega Produtos')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                      total_area: 10_000, useful_area: 8000, product_categories: [c1])
    p1 = ProductModel.create!(name: 'Teclado Digitador', supplier: supplier, product_category: c1,
                              weight: 200, width: 30, height: 5, length: 12)
    p2 = ProductModel.create!(name: 'Teclado Grande', supplier: supplier, product_category: c1,
                              weight: 200, width: 30, height: 5, length: 12)
    p3 = ProductModel.create!(name: 'Teclado Pequeno', supplier: supplier, product_category: c2,
                              weight: 200, width: 30, height: 5, length: 12)

    visit product_categories_path
    click_on 'Super Produtos'

    expect(page).to have_css 'h1', text: 'Super Produtos'
    expect(page).to have_css 'h3', text: 'Modelos de Produto Cadastrados'
    expect(page).to have_content 'Teclado Digitador'
    expect(page).to have_content 'Teclado Grande'
    expect(page).to have_css 'h3', text: 'Galpões Disponíveis:'
    expect(page).to have_content 'Maceió (MCZ)'
    expect(page).not_to have_content 'Teclado Pequeno'
  end

  it 'but there is no products in that category' do
    supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                                cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    c1 = ProductCategory.create!(name: 'Super Produtos')
    c2 = ProductCategory.create!(name: 'Mega Produtos')
    ProductModel.create!(name: 'Teclado Pequeno', supplier: supplier, product_category: c2,
                         weight: 200, width: 30, height: 5, length: 12)

    visit product_categories_path
    click_on 'Super Produtos'

    expect(page).not_to have_content 'Teclado Pequeno'
    expect(page).to have_css 'h1', text: 'Super Produtos'
    expect(page).to have_css 'h3', text: 'Modelos de Produto Cadastrados'
    expect(page).to have_content 'Ainda não existem produtos cadastrados nessa categoria'
  end

  it 'but there is no warehouses in that category' do
    supplier = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA',
                                cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    c1 = ProductCategory.create!(name: 'Super Produtos')
    c2 = ProductCategory.create!(name: 'Mega Produtos')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                      address: 'Av. Fernandes Lima', zip_code: '57050-000', city: 'Maceió', state: 'AL',
                      total_area: 10_000, useful_area: 8000, product_categories: [c2])
    ProductModel.create!(name: 'Teclado Pequeno', supplier: supplier, product_category: c2,
                         weight: 200, width: 30, height: 5, length: 12)

    visit product_categories_path
    click_on 'Super Produtos'

    expect(page).not_to have_content 'Maceió (MCZ)'
    expect(page).to have_css 'h1', text: 'Super Produtos'
    expect(page).to have_css 'h3', text: 'Galpões Disponíveis:'
    expect(page).to have_content 'Ainda não existem galpões disponíveis para essa categoria de produtos'
  end
end
