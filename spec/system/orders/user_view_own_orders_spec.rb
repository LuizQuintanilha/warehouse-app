require 'rails_helper'

describe 'Usuário vê  seus próprios pedidos' do
  it 'e deve estar autenticado' do
    # Arregne

    # Act
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    # Assert
    luiz = User.create!(
      name: 'Luiz',
      email: 'luiz@email.com',
      password: '123456'
    )
    first_warehouse = Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenida do Aeroporto, 1000',
      cep: '17352-000',
      description: 'Galpão destinado a cargas internacionais'
    )
    luana = User.create!(
      name: 'Luana',
      email: 'luana@email.com',
      password: '123456'
    )
    luna = User.create!(
      name: 'Luna',
      email: 'luna@email.com',
      password: '123456'
    )
    ache_supplier = Supplier.create!(
      corporate_name: 'ACHE LTDA',
      brand_name: 'ACME',
      registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000',
      zip: '23550-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'acheacme@email.com'
    )
    ammc_supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    one_order = Order.create!(
      user: luiz,
      warehouse: first_warehouse,
      supplier: ammc_supplier,
      estimated_delivery_date: 1.day.from_now,
      status: 'pending'
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('APRJ2345')
    two_order = Order.create!(
      user: luana,
      warehouse: first_warehouse,
      supplier: ache_supplier,
      estimated_delivery_date: 5.day.from_now,
      status: 'canceled'
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU2345')
    three_order = Order.create!(
      user: luiz,
      warehouse: first_warehouse,
      supplier: ache_supplier,
      estimated_delivery_date: 12.day.from_now,
      status: 'delivered'
    )
    # Act
    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content one_order.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content two_order.code
    expect(page).not_to have_content 'Cancelado'
    expect(page).to have_content three_order.code
    expect(page).to have_content 'Entregue'
  end

  it 'e visita um pedido' do
    luiz = User.create!(
      name: 'Luiz',
      email: 'luiz@email.com',
      password: '123456'
    )
    first_warehouse = Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenida do Aeroporto, 1000',
      cep: '17352-000',
      description: 'Galpão destinado a cargas internacionais'
    )
    ammc_supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    ache_supplier = Supplier.create!(
      corporate_name: 'ACHE LTDA',
      brand_name: 'ACME',
      registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000',
      zip: '23550-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'acheacme@email.com'
    )
    one_order = Order.create!(
      user: luiz,
      warehouse: first_warehouse,
      supplier: ammc_supplier,
      estimated_delivery_date: 1.day.from_now
    )

    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on one_order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content one_order.code
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: AMMC LTDA'
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    luiz = User.create!(
      name: 'Luiz',
      email: 'luiz@email.com',
      password: '123456'
    )
    luana = User.create!(
      name: 'Luana',
      email: 'luana@email.com',
      password: '123456'
    )
    first_warehouse = Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU', city: 'Guarulhos',
      area: 100_000,
      address: 'Avenida do Aeroporto, 1000',
      cep: '17352-000',
      description: 'Galpão destinado a cargas internacionais'
    )
    ammc_supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    one_order = Order.create!(
      user: luiz,
      warehouse: first_warehouse,
      supplier: ammc_supplier,
      estimated_delivery_date: 1.day.from_now
    )

    login_as(luana)
    visit order_path(one_order.id)

    expect(current_path).not_to eq order_path(one_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem acesso ao este pedido.'
  end

  it 'e vê itens do pedido' do
    supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro', state: 'RJ',
      email: 'lotusammc@email.com'
    )
    product_a = ProductModel.create!(
      name: 'Produto A',
      weight: 1, width: 10,
      height: 20, depth: 30,
      supplier: supplier,
      sku: 'PRODUTO-A'
    )
    product_b = ProductModel.create!(
      name: 'Produto B',
      weight: 2,
      width: 15,
      height: 25,
      depth: 35,
      supplier: supplier,
      sku: 'PRODUTO-B'
    )
    product_c = ProductModel.create!(
      name: 'Produto C',
      weight: 3,
      width: 20,
      height: 30,
      depth: 40,
      supplier: supplier,
      sku: 'PRODUTO-C'
    )
    luiz = User.create!(
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
      cep: '17352-000',
      description: 'Galpão destinado a cargas internacionais'
    )
    order = Order.create!(
      user: luiz,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now
    )
    OrderItem.create!(
      product_model: product_a,
      order: order,
      quantity: 17
    )
    OrderItem.create!(
      product_model: product_b,
      order: order,
      quantity: 12
    )

    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '17 x Produto A'
    expect(page).to have_content '12 x Produto B'
  end
end
