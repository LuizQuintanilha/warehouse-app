require 'rails_helper'


describe 'Usuário cadastra novo modelo de produto' do 
  it 'com sucesso' do 
    supplier = Supplier.create!(brand_name: 'Acer', corporate_name: 'Acer Tech LTDA', registration_number: '20002305010', 
                                full_address: 'Avenida Paulista, 10000', zip: '20220-000', city: 'São Paulo',
                                state: 'SP', email: 'acer.tech@email.com')

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo Produto'
    
    fill_in 'Nome', with: 'Monitor Acer 22 polegadas'
    fill_in 'Peso', with: 3_000
    fill_in 'Altura', with: 40
    fill_in 'Largura', with: 60
    fill_in 'Profundidade', with: 7
    fill_in 'SKU', with: 'MTAC-03W7'
    select 'Acer', from:   'Fornecedor'
    click_on 'Salvar'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'Monitor Acer 22 polegadas'
    expect(page).to have_content 'Fornecedor: Acer'
    expect(page).to have_content 'SKU: MTAC-03W7'
    expect(page).to have_content 'Dimensão: 40cm x 60cm x 7cm'
    expect(page).to have_content 'Peso: 3000g'
  
  end

end