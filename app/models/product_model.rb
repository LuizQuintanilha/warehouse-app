class ProductModel < ApplicationRecord
  belongs_to :supplier
  #validates :name, :weight, :height, :width, :depth, :sku, presence: true
end
