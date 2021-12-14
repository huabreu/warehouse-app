# describe 'User register product model' do
#   it 'with success' do
#     #arrange
#     Supplier.create(trade_name: 'Ceramicas Geek')
#     Supplier.create(trade_name: 'Imaginarium')

#     #act
#     visit root_path
#     click_on 'Cadastrar modelo de produto'
#     fill_in 'Nome', with 'Caneca Star Wars'
#     fill_in 'Peso', with '300'
#     fill_in 'Altura', with 12
#     fill_in 'Largura', with 8
#     fill_in 'Profundidade', with 14
#     fill_in 'Código SKU', with 'CNSW2020123456789112'
#     select 'Ceramicas Geek', from 'Fornecedor'

#     click_on 'Salvar'

#     #assert
#     expect(page).to have_content 'Modelo cadastrado com succeso!'
#     expect(page).to have_content 'Caneca Star Wars'
#     expect(page).to have_content '300g'
#     expect(page).to have_content 'Dimensões: 12 x 8 x 14' 
#     expect(page).to have_content 'SKU: CNSW2020123456789112'
#     expect(page).to have_content 'Fornecedor: Ceramicas Geek'
#   end
# end