class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items

  validates :name, :sku_code, 
  presence: true

  validates :sku_code, 
  format: { with: /\A[K].{20}\z/, message: "deve possuir 21 caracteres e começar com a letra K" }
end
