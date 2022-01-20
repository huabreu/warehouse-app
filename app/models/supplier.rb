class Supplier < ApplicationRecord
  has_many :product_models

  validates :trade_name, :company_name, :cnpj, :email,
            presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj,
            format: { with: /\A\d{13}\z/, message: 'deve possuir 13 dígitos' }
end
