require 'rails_helper'

describe 'usuário vê detalhes do fornecedor' do
  it 'a partir da tela inicial' do
    Supplier.create!(
      corporate_name: 'ACHE LTDA',
      brand_name: 'ACME',
      registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000',
      zip: '23550-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'acheacme@email.com'
    )
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    expect(page).to have_content('Fornecedor')
    expect(page).to have_content('ACME')
    expect(page).to have_content('ACHE LTDA')
    expect(page).to have_content('2000230501')
    expect(page).to have_content('Avenida dos Coqueiros, 1000')
    expect(page).to have_content('23550-000')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('RJ')
    expect(page).to have_content('acheacme@email.com')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
  end

  it 'e voltar para a tela inicial' do
    Supplier.create!(
      corporate_name: 'ACHE LTDA',
      brand_name: 'ACME',
      registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000',
      zip: '23550-000',
      city: 'Rio de Janeiro',
      state: 'RJ',
      email: 'acheacme@email.com'
    )
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
