class AddStatusToProductModels < ActiveRecord::Migration[6.1]
  def change
    add_column :product_models, :status, :integer, default: 1
  end
end
