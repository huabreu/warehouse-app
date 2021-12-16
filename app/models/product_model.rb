class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :sku_code, :weight, :height, :width, :length, 
  presence: true
  validates :weight, :height, :width, :length, 
  numericality: { :greater_than => 0 }

  def dimensions()
    "#{height} x #{width} x #{length}"
  end
end
