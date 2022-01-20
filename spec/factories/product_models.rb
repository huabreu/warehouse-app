FactoryBot.define do
  factory :product_model do
    name { 'Produto' }
    weight  { 10 }
    width { 10 }
    height  { 10 }
    length { 10 }
    supplier
    product_category
  end
end
