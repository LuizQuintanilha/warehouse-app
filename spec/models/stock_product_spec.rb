require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um número de série' do
    it 'ao criar um StockProduct' do
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
        estimated_delivery_date: 10.days.from_now,
        status: :delivered
      )
      product_a = ProductModel.create!(
        name: 'Produto A',
        weight: 1,
        width: 10,
        height: 20,
        depth: 30,
        supplier: supplier,
        sku: 'PRODUTO-A'
      )
      stock_product = StockProduct.create!(
        order: order,
        product_model: product_a,
        warehouse: warehouse
      )

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
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
      other_warehouse = Warehouse.create!(
        name: 'Aeroporto Galeão',
        code: 'AGL',
        city: 'São Paulo',
        area: 90_000,
        address: 'Avenida Paulista, 1000',
        cep: '15650-350',
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
        estimated_delivery_date: 10.days.from_now,
        status: :delivered
      )
      product_a = ProductModel.create!(
        name: 'Produto A',
        weight: 1,
        width: 10,
        height: 20,
        depth: 30,
        supplier: supplier,
        sku: 'PRODUTO-A'
      )
      stock_product = StockProduct.create!(
        order: order,
        product_model: product_a,
        warehouse: warehouse
      )
      original_serial = stock_product.serial_number
      stock_product.update(
        warehouse: other_warehouse
      )

      expect(stock_product.serial_number).to eq(original_serial)
    end
  end
end
