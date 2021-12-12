class Supplier < ApplicationRecord
  validates :trade_name, :company, :cnpj, :email,
  presence: true
end
