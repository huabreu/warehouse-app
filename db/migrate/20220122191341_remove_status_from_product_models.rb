class RemoveStatusFromProductModels < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_models, :status, :integer
  end
end
