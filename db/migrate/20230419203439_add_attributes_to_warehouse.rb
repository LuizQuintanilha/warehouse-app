class AddAttributesToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :cep, :string
    add_column :warehouses, :descripition, :string
  end
end
