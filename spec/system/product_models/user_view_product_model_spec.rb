require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'a partir do menu inicial' do 
    visit root_path

    within('nav') do 
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq(product_models_path)
  end
  
  it 'com sucesso' do 
    x = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Tech LTDA', registration_number: '20002305007', 
                                full_address: 'Avenida Paulista, 10000', zip: '20220-000', city: 'São Paulo',
                                state: 'SP', email: 'samsung.tech@email.com')
    first_product_model = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, 
                                              depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: x)
    second_product_model = ProductModel.create!(name: 'SoundBar 7.0 Surround', weight: 300, width: 80, height: 15, 
                                                depth: 20, sku: 'SOU71-SAMSU-NOI277', supplier: x)
    
    
    visit root_path
    within('nav') do 
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPT090')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar 7.0 Surround')
    expect(page).to have_content('SOU71-SAMSU-NOI277')
    expect(page).to have_content('Samsung')
  end

  it 'e não existem produtos cadastrados' do
    visit root_path
    within('nav') do 
      click_on 'Modelos de Produtos'
    end
    expect(page).to have_content('Nenhum modelo de produto cadastrado.')
  end
end