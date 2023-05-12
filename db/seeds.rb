Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
  address: 'Av. Santos Dummont, 1000', cep: '23500-000', 
  description: 'Galpão do Aeroporto do Rio')

Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, 
  address: 'Av. Alagoas, 1000', cep: '22350-000',
  description: 'Galpão do do Estado de Maceio')

x = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Tech LTDA', registration_number: '20002305007', 
    full_address: 'Avenida Paulista, 10000', zip: '20220-000', city: 'São Paulo',
    state: 'SP', email: 'samsung.tech@email.com')

ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, 
    depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: x)

ProductModel.create!(name: 'SoundBar 7.0 Surround', weight: 300, width: 80, height: 15, 
      depth: 20, sku: 'SOU71-SAMSU-NOI277', supplier: x)

User.create!(name:'Luiz', email:'luiz@email.com', password:'123456')
