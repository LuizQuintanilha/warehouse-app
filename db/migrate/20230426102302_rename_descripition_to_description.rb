class RenameDescripitionToDescription < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :descripition, :description
  end
end
