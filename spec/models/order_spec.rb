require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'deve ter um código'  do
      user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais' )
      supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
                                    full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
                                    city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-05-23')

      result = order.valid?

      expect(result).to be true
    end
  end
  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais' )
      supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
                                    full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
                                    city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-05-23')
      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end
    it 'e o código é único' do
      user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais' )
      supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
                                    full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
                                    city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-05-23')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2023-05-30')

      # Act
      second_order.save!
      #result = second_order.code
      # Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
