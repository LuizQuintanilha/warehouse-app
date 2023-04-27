require 'rails_helper'

describe 'Usuário cadastra um novo fornecedor' do 
  it 'a partir do menu' do 

    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    
    expect(page).to have_content('Cadastrar novo fornecedor')
    expect(page).to have_content('Razão Social')
    expect(page).to have_content('Marca')
    expect(page).to have_content('Número de registro')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('CEP')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('Estado')
    expect(page).to have_content('Email')
    expect(page).to have_button('Salvar')

  end

  it 'com sucesso' do

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    fill_in 'Razão Social', with: 'GS LTDA'
    fill_in 'Marca', with: 'GameShow'
    fill_in 'Número de registro', with: '20002305004'
    fill_in 'Endereço', with: 'Avenida Mario Bros, 10'
    fill_in 'CEP', with: '23580-000'
    fill_in 'Cidade', with: 'Belo Horizonte'
    fill_in 'Estado', with: 'MG'
    fill_in 'Email', with: 'gameshow@email.com'
    click_on 'Salvar'

    expect(page).to have_content('Fornecedor cadastrado com sucesso.')
    expect(page).to have_content('Fornecedor')
    expect(page).to have_content('GS LTDA')
    expect(page).to have_content('GameShow')
    expect(page).to have_content('20002305004')
    expect(page).to have_content('Avenida Mario Bros, 10')
    expect(page).to have_content('23580-000')
    expect(page).to have_content('Belo Horizonte')
    expect(page).to have_content('MG')
    expect(page).to have_content('gameshow@email.com')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
  end

  it 'sem sucesso' do 
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor' 

    fill_in 'Razão Social', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Número de registro', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Email', with: 'gameshow@email.com'
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível cadastrar fornecedor.')
  end
end