require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'deve ter um código' do
      user = User.create!(
        name: 'Luiz',
        email: 'luiz@email.com',
        password: '123456'
      )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'GRU',
        city: 'Guarulhos',
        area: 100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado a cargas internacionais'
      )
      supplier = Supplier.create!(
        corporate_name: 'ACHE LTDA',
        brand_name: 'ACME',
        registration_number: '2000230501',
        full_address: 'Avenida dos Coqueiros, 1000',
        zip: '23550-000',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'acheacme@email.com'
      )
      order = Order.new(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 5.days.from_now
      )

      result = order.valid?

      expect(result).to be true
    end

    it 'data prevista de entrega deve ser obrigatória' do
      # Arrange
      pedido = Order.new(estimated_delivery_date: '')
      # Act
      pedido.valid?
      result = pedido.errors.include?(:estimated_delivery_date)
      # Assert
      expect(result).to eq true
    end

    it 'data prevista de entrega não pode ser inferior à data atual' do
      pedido = Order.new(estimated_delivery_date: 1.day.ago)

      pedido.valid?
      result = pedido.errors.include?(:estimated_delivery_date)

      expect(result).to be true
      expect(pedido.errors[:estimated_delivery_date]).to include('A data não pode ser inferior a data atual')
    end

    it 'data prevista de entrega deve ser maior que data atual' do
      pedido = Order.new(estimated_delivery_date: 1.day.from_now)

      pedido.valid?
      result = pedido.errors.include?(:estimated_delivery_date)

      expect(result).to be false
    end
  end

  describe 'Gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(
        name: 'Luiz',
        email: 'luiz@email.com',
        password: '123456'
      )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'GRU',
        city: 'Guarulhos',
        area: 100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado a cargas internacionais'
      )
      supplier = Supplier.create!(
        corporate_name: 'ACHE LTDA',
        brand_name: 'ACME',
        registration_number: '2000230501',
        full_address: 'Avenida dos Coqueiros, 1000',
        zip: '23550-000',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'acheacme@email.com'
      )
      order = Order.new(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 10.days.from_now
      )
      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      user = User.create!(
        name: 'Luiz', email: 'luiz@email.com',
        password: '123456'
      )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'GRU', city: 'Guarulhos',
        area: 100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado a cargas internacionais'
      )
      supplier = Supplier.create!(
        corporate_name: 'ACHE LTDA',
        brand_name: 'ACME',
        registration_number: '2000230501',
        full_address: 'Avenida dos Coqueiros, 1000',
        zip: '23550-000',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'acheacme@email.com'
      )
      first_order = Order.create!(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 10.days.from_now
      )
      second_order = Order.new(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 10.days.from_now
      )
      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end

    it 'e não ser modificado' do
      user = User.create!(
        name: 'Luiz',
        email: 'luiz@email.com',
        password: '123456'
      )
      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'GRU',
        city: 'Guarulhos',
        area: 100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '15000-000',
        description: 'Galpão destinado a cargas internacionais'
      )
      supplier = Supplier.create!(
        corporate_name: 'ACHE LTDA',
        brand_name: 'ACME',
        registration_number: '2000230501',
        full_address: 'Avenida dos Coqueiros, 1000',
        zip: '23550-000',
        city: 'Rio de Janeiro',
        state: 'RJ',
        email: 'acheacme@email.com'
      )
      order = Order.create!(
        user: user,
        warehouse: warehouse,
        supplier: supplier,
        estimated_delivery_date: 10.days.from_now
      )
      original_code = order.code
      order.update(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq(original_code)
    end
  end
end
