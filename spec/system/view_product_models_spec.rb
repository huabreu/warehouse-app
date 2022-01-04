describe 'Visitor visit list of product models' do
  it 'and view all registered products' do
    supplier1 = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
    cnpj: '1234567891234', email: 'fbonito@hotmail.com')
    supplier2 = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Super Produtos')

    p1 = ProductModel.create!(name:'Teclado Digitador', supplier: supplier1, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)
    p2 = ProductModel.create!(name:'Som Muito Alto', supplier: supplier2, product_category: category, 
                               weight: 500, width: 30, height: 20, length: 12)

    visit root_path
    click_on 'Lista de produtos'

    expect(page).to have_css 'h1', text: 'Produtos Cadastrados'
    expect(page).to have_content 'Teclado Digitador'
    expect(page).to have_content 'Fornecedor Bonito'
    expect(page).to have_content p1.sku_code
    expect(page).to have_content 'Som Muito Alto'
    expect(page).to have_content 'Ipiranga Logisticas'
    expect(page).to have_content p2.sku_code
  end

  it 'but there is no product registered yet' do
    visit root_path
    click_on 'Lista de produtos'

    expect(page).to have_css 'h1', text: 'Produtos Cadastrados'
    expect(page).to have_content 'Não existem produtos cadastrados no sistema'
  end

  it 'and view a specific product model' do
    supplier1 = Supplier.create!(trade_name: 'Fornecedor Bonito', company_name: 'Fornecedor Bonito e Formoso SA', 
    cnpj: '1234567891234', address: 'Rua Formosa', email: 'fbonito@hotmail.com', phone: '32156589')
    category = ProductCategory.create!(name: 'Super Produtos')
    p = ProductModel.create!(name:'Teclado Digitador', supplier: supplier1, product_category: category,
                                 weight: 200, width: 30, height: 5, length: 12)

    visit product_models_path
    click_on 'Teclado Digitador'

    expect(page).to have_content 'Teclado Digitador'
    expect(page).to have_content 'Categoria: Super Produtos'
    expect(page).to have_content 'Fornecedor: Fornecedor Bonito'
    expect(page).to have_content "SKU: #{p.sku_code}"
    expect(page).to have_content 'Peso: 200 g'
    expect(page).to have_content 'Largura: 30 cm'
    expect(page).to have_content 'Altura: 5 cm'
    expect(page).to have_content 'Comprimento: 12 cm'

  end
end