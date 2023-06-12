require 'rails_helper'
describe 'Usuário edita um  galpão' do
  it 'a partir da tela inicial' do
    # arrange
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenidade do Aeroporto, 1000',
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )
    # act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    # assert
    expect(page).to have_content('Editar Galpão')
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('Área', with: '100000')
    expect(page).to have_field('Endereço', with: 'Avenidade do Aeroporto, 1000')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
  end

  it 'atualizado com sucesso' do
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenidade do Aeroporto, 1000',
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )
    # act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    fill_in 'CEP', with: '15550-000'
    fill_in 'Endereço', with: 'Avenidade Paulista, 1000'

    click_on 'Enviar'

    # expect(current_path).to eq(warehouse_path)
    expect(page).to have_content('Galpão atualizado com sucesso')
    expect(page).to have_content('15550-000')
    expect(page).to have_content('Avenidade Paulista, 1000')
  end

  it 'e mantém os campos obrigatórios' do
    Warehouse.create!(
      name: 'Aeroporto SP',
      code: 'GRU',
      city: 'Guarulhos',
      area: 100_000,
      address: 'Avenidade do Aeroporto, 1000',
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
    )
    # act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar galpão.')
  end
end
