class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :trade_name
      t.string :company
      t.string :cnpj
      t.string :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
