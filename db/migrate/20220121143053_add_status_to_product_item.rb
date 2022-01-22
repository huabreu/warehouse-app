class AddStatusToProductItem < ActiveRecord::Migration[6.1]
  def change
    add_column :product_items, :status, :boolean, default: true
  end
end
