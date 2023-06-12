require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    luna = User.create!(name: 'Luna', email: 'luna@email.com', password: '123456')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                        description: 'Galpão destinado a cargas internacionais')
    ammc_supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                     full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    order = Order.create!(user: luiz, warehouse: first_warehouse, supplier: ammc_supplier,
                          estimated_delivery_date: 1.day.from_now)

    login_as(luna)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    expect(response).to redirect_to(root_path)
  end
end
