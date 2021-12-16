class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :sku_code, :weight, :height, :width, :length, 
  presence: true

  def dimensions()
    "#{height} x #{width} x #{length}"
  end
end
