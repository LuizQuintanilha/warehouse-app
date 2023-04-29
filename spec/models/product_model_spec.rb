require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid' do
    it 'name is mandatory' do 
      #arrange
      supplier = Supplier.create!(brand_name: 'Acer', corporate_name: 'Acer Tech LTDA', registration_number: '20002305010', 
                                  full_address: 'Avenida Paulista, 10000', zip: '20220-000', city: 'São Paulo',
                                  state: 'SP', email: 'acer.tech@email.com')

      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, 
                                              depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

      
      #act
      result = pm.valid?

      #assert
      expect(result).to eq(false)
    end
    it 'sku is mandatory' do 
      #arrange
      supplier = Supplier.create!(brand_name: 'Acer', corporate_name: 'Acer Tech LTDA', registration_number: '20002305010', 
                                  full_address: 'Avenida Paulista, 10000', zip: '20220-000', city: 'São Paulo',
                                  state: 'SP', email: 'acer.tech@email.com')

      pm = ProductModel.new(name: 'TV32', weight: 8000, width: 70, height: 45, 
                                              depth: 10, sku: '', supplier: supplier)

      
      #act
      result = pm.valid?

      #assert
      expect(result).to eq(false)
    end
  end
 
end
