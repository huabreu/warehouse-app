FactoryBot.define do
  factory :supplier do
    trade_name { 'Fornecedor' }
    company_name { 'Fornecedor SA' }
    cnpj { '1134567818234' }
    address { 'Viaduto, 1' }
    email { 'supplier@mail.com' }
    phone { '345896654' }
  end
end
