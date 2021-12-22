require 'rails_helper'

describe 'visitor navigates' do
  it 'using the menu' do
    visit root_path

    #assert1
    # expect(page).to have_css 'nav a', text:'Cadastrar novo galpão'
    # expect(page).to have_css 'nav a', text:'Página inicial'
    # expect(page).to have_css 'nav a', text:'Cadastrar novo fornecedor'
    
    #assert2
    # within "nav.User Menu" do
      expect(page).to have_link 'Página inicial', href: root_path
      expect(page).to have_link 'Cadastrar novo galpão', href: new_warehouse_path
      expect(page).to have_link 'Cadastrar novo fornecedor', href: new_supplier_path
    # end
  end
end