require 'rails_helper'

describe 'Usuário vê todos os fornecedores' do
  it 'a partir do menu' do
    visit root_path

    within('nav') do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq(suppliers_path)
  end

  it 'com sucesso' do
    Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                     full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                     city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')
    Supplier.create!(corporate_name: 'AQI LTDA', brand_name: 'AKI', registration_number: '2000230502',
                     full_address: 'Avenida das Jaqueiras, 2000', zip: '20550-000',
                     city: 'São Paulo', state: 'SP', email: 'aki@email.com')
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RJ')

    expect(page).to have_content('AKI')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Não existem fornecedores cadastrados.')
  end
end
