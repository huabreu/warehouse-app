require 'rails_helper'

describe 'User enters new items' do
  context 'through link on home page' do
    it 'visitor is unable to access the form' do
      visit product_items_entry_path
      # assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    end

    it 'with success' do
      user = create(:user)
      c = create(:product_category)
      w = create(:warehouse, code: 'MCZ', product_category_ids: [c.id])
      create(:warehouse, name: 'Juiz de Fora', code: 'JFG')
      pm = create(:product_model, name: 'Teclado Digitador',
                                  product_category: c)
      s = create(:supplier, cnpj: '1236464643231')
      create(:product_model, product_category: c, supplier: s)

      login_as(user)
      visit root_path
      click_on 'Entrada de Itens'
      fill_in 'Quantidade', with: 3
      select 'MCZ', from: 'Galpão Destino'
      select 'Teclado Digitador', from: 'Produto'
      # preco
      # numero lote
      click_on 'Confirmar'

      expect(page).to have_content 'Entrada do novo lote realizada com sucesso!'
      expect(current_path).to eq warehouse_path(w.id)
      expect(page).to have_css('h2', text: 'Estoque')
      within "div#product-#{pm.id}" do
        # expect(page).to have_css('h3', text: 'Estoque')
        expect(page).to have_content 'Teclado Digitador'
        expect(page).to have_content 'Quantidade: 3'
      end
    end

    context 'without success' do
      it 'because invalid product category' do
        user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
        s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                             cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
        c = ProductCategory.create!(name: 'Teste')
        c2 = ProductCategory.create!(name: 'Erro')
        w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                               address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                               zip_code: '57050-000', total_area: 10_000, useful_area: 8000, product_category_ids: [c2.id])
        p1 = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: c,
                                  weight: 200, width: 30, height: 5, length: 12)

        login_as(user)
        visit root_path
        click_on 'Entrada de Itens'
        fill_in 'Quantidade', with: 2
        select 'MCZ', from: 'Galpão Destino'
        select 'Teclado Digitador', from: 'Produto'
        click_on 'Confirmar'

        expect(page).to have_content 'Erro! Não foi possível completar a solicitação'
        expect(current_path).to eq product_items_entry_path
        expect(page).to have_css('h1', text: 'Novo Lote de Produtos')
      end
    end
  end

  context 'through form on warehouse details page' do
    it 'visitor is unable to access the form' do
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                            address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                            zip_code: '57050-000', total_area: 10_000, useful_area: 8000)

      visit warehouse_path(w.id)
      # assert
      expect(page).not_to have_content 'Entrada de Itens'
      expect(page).to have_css('h1', text: 'Maceió')
    end

    it 'with success' do
      user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
      s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                           cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
      c = ProductCategory.create!(name: 'Teste')
      w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                             address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL', product_category_ids: [c.id],
                             zip_code: '57050-000', total_area: 10_000, useful_area: 8000)
      w2 = Warehouse.create!(name: 'Curitiba', code: 'CTB', description: 'Ótimo galpão mas é frio',
                             address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
                             total_area: 5000, useful_area: 4000, product_category_ids: [c.id])
      p1 = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: c,
                                weight: 200, width: 30, height: 5, length: 12)
      p2 = ProductModel.create!(name: 'Som Muito Alto', supplier: s, product_category: c,
                                weight: 500, width: 30, height: 20, length: 12)

      login_as(user)
      visit root_path
      click_on 'Maceió'
      fill_in 'Quantidade', with: 3
      select 'Teclado Digitador', from: 'Produto'
      click_on 'Confirmar'

      expect(current_path).to eq warehouse_path(w1.id)
      expect(page).to have_content 'Entrada de itens realizada com sucesso!'
      expect(page).to have_css('h2', text: 'Estoque')
      within "div#product-#{p1.id}" do
        expect(page).to have_content 'Teclado Digitador'
        expect(page).to have_content 'Quantidade: 3'
      end
    end

    context 'without success' do
      it 'because invalid quantity' do
        user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
        s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
                             cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
        c = ProductCategory.create!(name: 'Teste')
        c2 = ProductCategory.create!(name: 'Erro')
        w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
                               address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
                               zip_code: '57050-000', total_area: 10_000, useful_area: 8000, product_category_ids: [c.id])
        p1 = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: c,
                                  weight: 200, width: 30, height: 5, length: 12)

        login_as(user)
        visit root_path
        click_on 'Maceió'
        fill_in 'Quantidade', with: -3
        select 'Teclado Digitador', from: 'Produto'
        click_on 'Confirmar'

        expect(current_path).to eq warehouse_path(w1.id)
        expect(page).to have_content 'Erro! Não foi possível realizar a entrada dos itens'
        expect(page).not_to have_content "div#product-#{p1.id}"
      end

      # it 'because inactive product model' do
      #   user = User.create!(email: 'hugorabreu@gmail.com', password: '123456')
      #   s = Supplier.create!(trade_name: 'Ipiranga Logisticas', company_name: 'Ipiranga Logisticas SA',
      #                        cnpj: '1134567818234', address: 'Av. Don Pedro II', email: 'iippiiranga@hotmail.com', phone: '345896654')
      #   c = ProductCategory.create!(name: 'Teste')
      #   c2 = ProductCategory.create!(name: 'Erro')
      #   w1 = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão no centro da cidade',
      #                          address: 'Av. Fernandes Lima', city: 'Maceió', state: 'AL',
      #                          zip_code: '57050-000', total_area: 10_000, useful_area: 8000, product_category_ids: [c.id])
      #   p1 = ProductModel.create!(name: 'Teclado Digitador', supplier: s, product_category: c,
      #                             weight: 200, width: 30, height: 5, length: 12)
      #   p1.inactive!

      #   login_as(user)
      #   visit root_path
      #   click_on 'Maceió'
      #   fill_in 'Quantidade', with: 3
      #   select 'Teclado Digitador', from: 'Produto'
      #   click_on 'Confirmar'

      #   expect(current_path).to eq warehouse_path(w1.id)
      #   expect(page).to have_content 'Erro! Não foi possível realizar a entrada dos itens'
      #   expect(page).not_to have_content "div#product-#{p1.id}"
      # end
    end
  end
end
