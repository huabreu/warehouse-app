require 'rails_helper'

describe 'visitor view homepage' do
  it 'view welcome message' do
    visit root_path

    expect(page).to have_content 'Bem-vindo ao Warehouse App'
    
  end
end