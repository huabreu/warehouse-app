require 'rails_helper'

describe 'visitor navigates' do
  it 'using the menu' do
    visit root_path

    #assert1
    expect(page).to have_css 'nav a', text:'Cadastrar um novo galpão'
    expect(page).to have_css 'nav a', text:'Página inicial'
    #assert2
    within 'nav' do
      expect(page).to have_link 'Página inicial', href: root_path
      expect(page).to have_link 'Cadastrar um novo galpão', href: new_warehouse_path
    end
  end
end