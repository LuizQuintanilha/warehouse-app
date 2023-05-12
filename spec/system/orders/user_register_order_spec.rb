require 'rails_helper'

describe 'usuário cadastra um pedido' do 
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Luiz', email: 'luiz@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais' )
    Warehouse.create!(name: 'Galpão RJ', code: 'SDRJ', city: 'Rio de Janeiro', area: 90_000,
                                    address: 'Avenida Rio Branco, 2000', cep: '15500-000',
                                    description: 'Galpão do aeroporto Santos Drummmont' )

    supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
                                city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
    Supplier.create!(corporate_name: 'AMMC LTDA', brand_name: 'LOTUS',registration_number: '2000230513',
                     full_address: 'Avenida das Mangas, 1000', zip: '23500-000', 
                     city: 'Rio de Janeiro', state: 'RJ', email:'lotusammc@email.com')      
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')                      
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista', with: '20/05/2023'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACHE LTDA'
    expect(page).to have_content 'Usuário Responsável: Luiz - luiz@email.com'
    expect(page).not_to have_content 'Galpão RJ'
    expect(page).not_to have_content 'AMMC LTDA'
    expect(page).to have_content 'Data Prevista: 20/05/2023'  
  end
  
end

