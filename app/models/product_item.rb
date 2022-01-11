class ProductItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model

  before_validation :generate_sku

  validates :sku_code,
  presence: true
  validates :sku_code, 
  uniqueness: true

  private

  def generate_sku
    if sku_code.nil?
      self.sku_code = SecureRandom.alphanumeric(20) 
    end
  end  
end
