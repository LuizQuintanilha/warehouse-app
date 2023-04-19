require 'rails_helper'

#primeiro cenário de teste
describe 'usuário visita tela inicial' do 
  it 'e vê o nome da app' do
    # Arrange

    # Act
    visit('/') #tela inicial ou root_path
    # Assert
    expect(page).to have_content('Galpões & Estoques')
  end
end