class RenameCompanyToCompanyName < ActiveRecord::Migration[6.1]
  def change
    rename_column :suppliers, :company, :company_name
  end
end
