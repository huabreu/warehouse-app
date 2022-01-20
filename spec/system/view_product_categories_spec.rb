require 'rails_helper'

describe 'Visitor visit list of product categories' do
  it 'and view all registered categories' do
    ProductCategory.create!(name: 'Exclusiva')
    ProductCategory.create!(name: 'Marretas')

    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_css 'h1', text: 'Categorias de Produto Cadastradas'
    expect(page).to have_content 'Exclusiva'
    expect(page).to have_content 'Marretas'
  end

  it 'but there is no category registered yet' do
    visit root_path
    click_on 'Categorias de produto'

    expect(page).to have_css 'h1', text: 'Categorias de Produto Cadastradas'
    expect(page).to have_content 'Não existem categorias cadastradas no sistema'
  end
end
