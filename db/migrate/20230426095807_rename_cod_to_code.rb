class RenameCodToCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :warehouses, :cod, :code
  end
end
