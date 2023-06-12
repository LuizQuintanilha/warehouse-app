require 'rails_helper'

# primeiro cenário de teste
describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange
    # Act
    visit root_path # tela inicial ou root_path
    # Assert
    expect(page).to have_content('Galpões & Estoques')
    expect(page).to have_link('Galpões & Estoques', href: root_path)
  end

  it 'e vê o os galpões cadastrados' do
    # Arrange Cadastrar dois galpões Rio e SP
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                     address: 'Av. Santos Dummont, 1000', cep: '23500-000',
                     description: 'Galpão do Aeroporto do Rio')

    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                     address: 'Av. Alagoas, 1000', cep: '22350-000',
                     description: 'Galpão do do Estado de Maceio')
    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to  have_content('Rio')
    expect(page).to  have_content('SDU')
    expect(page).to  have_content('Cidade: Rio de Janeiro')
    expect(page).to  have_content('60000 m²')

    expect(page).to  have_content('Maceio')
    expect(page).to  have_content('Código: MCZ')
    expect(page).to  have_content('Cidade: Maceio')
    expect(page).to  have_content('50000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange

    # Atc
    visit root_path

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
