class Warehouse < ApplicationRecord
  validates :name, :code, :city,  :area, :description, :address, :cep, presence: true
  #validates atributos, tipo_da_validação: true
  validates :code, uniqueness: true

  def full_description
    "#{code} | #{name}"
  end
end
