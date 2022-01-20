FactoryBot.define do
  factory :warehouse do
    name { 'Galpão' }
    code { 'GPA' }
    description { 'Galpão para guardar produtos' }
    address { 'Rua Principal, 1' }
    city { 'Santos' }
    state  { 'SP' }
    zip_code { '00000-000' }
    total_area { 10 }
    useful_area { 5 }
  end
end
