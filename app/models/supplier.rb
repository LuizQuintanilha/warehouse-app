class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :full_address, :zip, :city, :state, :email,
            presence: true
  validates :corporate_name, :registration_number, uniqueness: true
end
