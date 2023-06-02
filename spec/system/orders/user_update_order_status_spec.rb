require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                  description: 'Galpão destinado a cargas internacionais' )
    supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS',registration_number: '2000230513',
                                full_address: 'Avenida das Mangas, 1000', zip: '23500-000', 
                                city: 'Rio de Janeiro', state: 'RJ', email:'lotusammc@email.com') 
    order = Order.create!(user: luiz, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: :pending)
                          
    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Cancelado'

  end

  it 'e pedido foi cancelado' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                  description: 'Galpão destinado a cargas internacionais' )
    supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS',registration_number: '2000230513',
                                full_address: 'Avenida das Mangas, 1000', zip: '23500-000', 
                                city: 'Rio de Janeiro', state: 'RJ', email:'lotusammc@email.com') 
    order = Order.create!(user: luiz, warehouse: warehouse, supplier: supplier, 
                          estimated_delivery_date: 1.day.from_now, status: :pending)
                          
    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Cancelado'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'

  end
end