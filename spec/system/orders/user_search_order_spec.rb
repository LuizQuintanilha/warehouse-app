require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')

    # Act
    login_as(user)
    visit root_path
    # Assert
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    # Assert
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do
    # Arrange
    user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais')
    galpao = Warehouse.create!(name: 'Galpão RJ', code: 'SDRJ', city: 'Rio de Janeiro', area: 90_000,
                               address: 'Avenida Rio Branco, 2000', cep: '15500-000',
                               description: 'Galpão do aeroporto Santos Drummmont')

    supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')
    fornecedor = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                  full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                  city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now)
    # Act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'
    # Assert
    expect(page).to have_content "Resultado da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACHE LTDA'
  end
  it 'e encontra multiplos pedidos' do
    # Arrange
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    luana = User.create!(name: 'Luana', email: 'luana@email.com', password: '123456')
    luna = User.create!(name: 'Luna', email: 'luna@email.com', password: '123456')
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                        address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                        description: 'Galpão destinado a cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Aeroporto Rio', code: 'APRJ', city: 'Rio de Janeiro', area: 90_000,
                                         address: 'Avenida Rio Branco, 2000', cep: '15565-000',
                                         description: 'Galpão do aeroporto Santos Drummmont')

    ache_supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                                     full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')
    ammc_supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                     full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                     city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    one_order = Order.create!(user: luiz, warehouse: second_warehouse, supplier: ammc_supplier,
                              estimated_delivery_date: 3.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('APRJ2345')
    two_order = Order.create!(user: luiz, warehouse: first_warehouse, supplier: ache_supplier,
                              estimated_delivery_date: 10.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('APRJ2345')
    three_order = Order.create!(user: luiz, warehouse: first_warehouse, supplier: ache_supplier,
                                estimated_delivery_date: 5.day.from_now)

    # Act
    login_as(luiz)
    visit root_path
    fill_in 'Buscar Pedido', with: 'AP'
    click_on 'Buscar'
    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('APRJ2345')
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).not_to have_content('GRU12345')
    expect(page).not_to have_content 'Galpão Destino: APRJ | Aeroporto Rio'
  end
end
