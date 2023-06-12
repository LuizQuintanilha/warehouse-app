require 'rails_helper'

describe 'Usuário vê oestoque' do

  it 'na tela do galpão' do

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
      address: 'Avenidade do Aeroporto, 1000',
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    product_cadeira_gamer = ProductModel.create!(
      name: 'CADEIRA GAMER',
      weight: 5000,
      width: 100,
      height: 75,
      depth: 90,
      supplier: supplier,
      sku: 'CADEIRA-GAMER-1245'
    )
    product_tv = ProductModel.create!(
      name: 'TV LG 40',
      weight: 2,
      width: 15,
      height: 25,
      depth: 35,
      supplier: supplier,
      sku: 'TVLG-40-4680'
    )
    product_sofa = ProductModel.create!(
      name: 'Sofa Gráfite 3 lugares',
      weight: 2,
      width: 15,
      height: 25,
      depth: 35,
      supplier: supplier,
      sku: 'SOGRA3-7195'
    )
    order = Order.create!(
      user: luiz,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now
    )
    3.times do
      stock_product_a = StockProduct.create!(
      warehouse: warehouse,
      product_model: product_cadeira_gamer,
      order: order
      )
    end
    2.times do
      stock_product_a = StockProduct.create!(
      warehouse: warehouse,
      product_model: product_tv,
      order: order
      )
    end
    login_as(luiz)
    visit(root_path)
    click_on 'Aeroporto SP'
    within("section#stock_products") do 
      expect(page).to have_content 'Itens do Estoque'
      expect(page).to have_content '3 x CADEIRA GAMER'
      expect(page).to have_content '2 x TV LG 40'
      expect(page).not_to have_content 'Sofa Gráfite 3 lugares'
    end
  end

  it 'e dá baixa em um item' do

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
      address: 'Avenidade do Aeroporto, 1000',
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )
    supplier = Supplier.create!(
      corporate_name: 'AMMC LTDA',
      brand_name: 'LOTUS',
      registration_number: '2000230513',
      full_address: 'Avenida das Mangas, 1000',
      zip: '23500-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'lotusammc@email.com'
    )
    product_tv = ProductModel.create!(
      name: 'TV LG 40',
      weight: 2,
      width: 15,
      height: 25,
      depth: 35,
      supplier: supplier,
      sku: 'TVLG-40-4680'
    )
    order = Order.create!(
      user: luiz,
      warehouse: warehouse,
      supplier: supplier,
      estimated_delivery_date: 1.day.from_now
    )
    2.times { StockProduct.create!(order: order, product_model: product_tv, warehouse: warehouse ) }

    login_as luiz
    visit root_path
    click_on 'Aeroporto SP'
    select 'TVLG-40-4680', from: 'Item para saída'
    fill_in 'Destinatário', with: 'Maria de Lurdes Figueiredo'
    fill_in 'Endereço Destino', with: 'Rua dos Cajas, n100, Rio de Janeiro, RJ, CEP: 26500-100'
    click_on 'Confirmar'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retidado com sucesso'
    expect(page).to have_content 'TVLG-40-4680'

  end
end