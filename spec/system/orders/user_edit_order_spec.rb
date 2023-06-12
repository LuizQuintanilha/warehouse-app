require 'rails_helper'

describe 'Usuária edita um pedido' do
  it 'e deve estar autenticado' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                        description: 'Galpão destinado a cargas internacionais')
    ammc_supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                     full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    order = Order.create!(user: luiz, warehouse: first_warehouse, supplier: ammc_supplier,
                          estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                        description: 'Galpão destinado a cargas internacionais')
    ammc_supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                     full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    ache_supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                                     full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')
    order = Order.create!(user: luiz, warehouse: first_warehouse, supplier: ammc_supplier,
                          estimated_delivery_date: 1.day.from_now)

    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista', with: '12/12/2050'
    select 'ACHE LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: ACHE LTDA'
    expect(page).to have_content 'Data Prevista: 12/12/2050'
  end

  it 'caso seja o responsável' do
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

    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end
end
