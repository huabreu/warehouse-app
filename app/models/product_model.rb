class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items

  validates :name, :sku_code, :weight, :height, :width, :length, 
  presence: true
  validates :weight, :height, :width, :length, 
  numericality: { :greater_than => 0 }

  def dimensions()
    "#{height} x #{width} x #{length}"
  end
end
