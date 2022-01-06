class Warehouse < ApplicationRecord
  has_many :product_items

  validates :name, :code, :description, :address, :city, :state, :zip_code,
            :total_area, :useful_area,
  presence: true
  validates :name, :code, 
  uniqueness: true 
  validates :zip_code, 
  format: { with: /\A\d{5}-\d{3}\z/, message: "deve estar no formato 00000-000" }
end
