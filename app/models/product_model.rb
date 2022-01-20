class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :product_category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  has_many :product_items

  before_validation :generate_sku

  validates :name, :weight, :height, :width, :length,
            presence: true
  validates :weight, :height, :width, :length,
            numericality: { greater_than: 0 }
  validates :sku_code,
            uniqueness: true
  # validates :sku_code,
  # format: { with: /\A\S{20}\z/, message: "deve possuir 20 caracteres" }

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  private

  def generate_sku
    self.sku_code = SecureRandom.alphanumeric(20) if sku_code.nil?
  end
end
