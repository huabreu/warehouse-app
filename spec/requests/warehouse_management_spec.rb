require 'rails_helper'

describe 'WarehouseRequests', type: :request do
  it 'should refuse warehouse creation if not login' do
    post '/warehouses'

    expect(response.status).to eq 302
    expect(response.redirect_url).to eq new_user_session_url
  end

  it 'should refuse warehouse creation if not login 2' do
    post '/warehouses'
    follow_redirect!

    expect(response.body).to include 'Entrar'
  end
end