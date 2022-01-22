class RemoveStatusFromProductItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_items, :status, :boolean
  end
end
