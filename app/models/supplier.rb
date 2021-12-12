class Supplier < ApplicationRecord
  validates :trade_name, :company, :cnpj, :email,
  presence: true
  validates :cnpj, uniqueness: true, length: { is: 13 }
end
