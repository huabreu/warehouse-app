require 'rails_helper'

describe 'User login' do
  it 'with success' do
    User.create!(email: 'hugorabreu@gmail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'hugorabreu@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_content 'Olá usuário hugorabreu@gmail.com'
  end
end