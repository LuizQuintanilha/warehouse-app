require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    luiz = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '17352-000',
                                  description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS', registration_number: '2000230513',
                                full_address: 'Avenida das Mangas, 1000', zip: '23500-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'lotusammc@email.com')
    order = Order.create!(user: luiz, warehouse: warehouse, supplier: supplier,
                          estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth: 30,
                                     supplier: supplier, sku: 'PRODUTO-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 2, width: 15, height: 25, depth: 35,
                                     supplier: supplier, sku: 'PRODUTO-B')

    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro forncedor' do
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
    supplier_a = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    supplier_b = Supplier.create!(
      corporate_name: 'BBC LTDA',
      brand_name: 'BOCAJR',
      registration_number: '2000202313',
      full_address: 'Avenida das Goiabas, 1000',
      zip: '25850-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'bocajr@email.com'
    )
    order = Order.create!(
      user: luiz,
      warehouse: warehouse,
      supplier: supplier_a,
      estimated_delivery_date: 1.day.from_now
    )
    product_a = ProductModel.create!(
      name: 'Produto A',
      weight: 1,
      width: 10,
      height: 20,
      depth: 30,
      supplier: supplier_a,
      sku: 'PRODUTO-A'
    )
    product_b = ProductModel.create!(
      name: 'Produto B',
      weight: 2,
      width: 15,
      height: 25,
      depth: 35,
      supplier: supplier_b,
      sku: 'PRODUTO-B'
    )

    login_as(luiz)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
