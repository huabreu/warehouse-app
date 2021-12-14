class Warehouse < ApplicationRecord
  validates :name, :code, :description, :address, :city, :state, :zip_code,
            :total_area, :useful_area,
  presence: true
  validates :name, :code, uniqueness: true 
  validates :zip_code, format: { with: /\d{5}-\d{3}/, message: "must be on 00000-000 format" }
end
