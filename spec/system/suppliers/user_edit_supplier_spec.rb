require 'rails_helper'

describe 'Usuário edita um fornecedor' do 
  it 'a partir do menu inicial' do 
    supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
      city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    expect(page).to have_content('Editar dados do fornecedor')
    expect(page).to have_field('Razão Social', with: 'ACHE LTDA')
    expect(page).to have_field('Marca', with: 'ACME')
    expect(page).to have_field('Número de registro', with: '2000230501')
    expect(page).to have_field('Endereço', with: 'Avenida dos Coqueiros, 1000')
    expect(page).to have_field('CEP', with: '23550-000')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Estado', with: 'RJ')
    expect(page).to have_field('Email', with: 'acheacme@email.com')
    expect(page).to have_button('Salvar')
 
  end

  it 'atualizado com  sucesso' do 
    supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
      city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'Razão Social', with: 'ACCHE LTDA'
    fill_in 'Endereço', with: 'Avenida Abacaxi, 25'

    click_on 'Salvar'

    expect(page).to have_content('ACCHE LTDA')
    expect(page).to have_content('Avenida Abacaxi, 25')
  end

  it 'e mantém os campos obrigátorios' do 
    supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME',registration_number: '2000230501',
      full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000', 
      city: 'Rio de Janeiro', state: 'RJ', email:'acheacme@email.com')
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    fill_in 'Razão Social', with: ''
    fill_in 'Endereço', with: ''

    click_on 'Salvar'

    expect(page).to have_content('Não foi possível atualizar dados do forcenedor.')

  end
end