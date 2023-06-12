Warehouse.create(
  name: 'Rio',
  code: 'SDU',
  city: 'Rio de Janeiro',
  area: 60_000,
  address: 'Av. Santos Dummont, 1000',
  cep: '23500-000',
  description: 'Galpão do Aeroporto do Rio'
)

warehouse = Warehouse.create(
  name: 'Maceio',
  code: 'MCZ',
  city: 'Maceio',
  area: 50_000,
  address: 'Av. Alagoas, 1000',
  cep: '22350-000',
   description: 'Galpão do do Estado de Maceio'
  )

supplier = Supplier.create!(
  brand_name: 'Samsung',
  corporate_name: 'Samsung Tech LTDA',
  registration_number: '20002305007',
  full_address: 'Avenida Paulista, 10000',
  zip: '20220-000',
  city: 'São Paulo',
  state: 'SP',
  email: 'samsung.tech@email.com'
)

ProductModel.create!(
  name: 'TV 32',
  weight: 8000,
  width: 70,
  height: 45,
  depth: 10,
  sku: 'TV32-SAMSU-XPT090',
  supplier: supplier
)

ProductModel.create!(
  name: 'SoundBar 7.0 Surround',
  weight: 300,
  width: 80,
  height: 15,
  depth: 20,
  sku: 'SOU71-SAMSU-NOI277',
  supplier: supplier
)

luiz = User.create!(
  name: 'Luiz',
  email: 'luiz@email.com',
  password: '123456'
)

order = Order.create!(
  user: luiz,
  warehouse: warehouse,
  supplier: supplier,
  estimated_delivery_date: 1.day.from_now
)

ProductModel.create!(
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

ProductModel.create!(
  name: 'Sofa Gráfite 3 lugares',
  weight: 2,
  width: 15,
  height: 25,
  depth: 35,
  supplier: supplier,
  sku: 'SOGRA3-7195'
)

StockProduct.create!(
  warehouse: warehouse,
  product_model: product_tv,
  order: order
)