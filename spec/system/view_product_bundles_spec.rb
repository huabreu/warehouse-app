describe 'Visitor visit list of product bundles' do
  it 'and view all registered bundles' do
    ProductBundle.create!(name: 'Super Bundle', sku_code: 'KSUMEBU25122021123456')
    ProductBundle.create!(name: 'Hiper Bundle', sku_code: 'KHIMEBU25122021123456')

    visit root_path
    click_on 'Lista de bundles'

    expect(page).to have_css 'h1', text: 'Bundles Cadastrados'
    expect(page).to have_content 'Super Bundle'
    expect(page).to have_content 'KSUMEBU25122021123456'
    expect(page).to have_content 'Hiper Bundle'
    expect(page).to have_content 'KHIMEBU25122021123456'
  end

  it 'but there is no product registered yet' do
    visit root_path
    click_on 'Lista de bundles'

    expect(page).to have_css 'h1', text: 'Bundles Cadastrados'
    expect(page).to have_content 'Não existem bundles cadastrados no sistema'
  end

  it 'and view a specific product bundle' do
    supplier = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA', 
    cnpj: '1234567811234', email: 'iippiiranga@hotmail.com')
    category = ProductCategory.create!(name: 'Teste')
    model1 = ProductModel.create!(name:'Caixas de Som Blast', supplier: supplier, product_category: category,
    weight: 200, width: 30, height: 15, length: 12)
    model2 = ProductModel.create!(name:'Som Muito Alto', supplier: supplier, product_category: category,
    weight: 500, width: 30, height: 20, length: 12)
    ProductBundle.create!(name: 'Super Bundle', sku_code: 'KSUMEBU25122021123456', product_models: [model1, model2])

    visit product_bundles_path
    click_on 'Super Bundle'

    expect(page).to have_content 'Super Bundle'
    expect(page).to have_content 'SKU: KSUMEBU25122021123456'
    expect(page).to have_content 'Som Muito Alto'
    expect(page).to have_content 'Caixas de Som Blast'
    expect(page).to have_link 'Voltar', href: product_bundles_path
  end
end