require 'rails_helper'

describe 'Usuário excluir um galpão ' do 
  it 'com sucesso' do 
    warehouse = Warehouse.create!(name: 'MG-Belo Horizonte', code: 'BHS', area: 65_0000, city: 'Belo Horizonte', 
                                  address: 'Av do Pão de Queijo, 44', cep:'23500-000', 
                                  description: 'Galpão do Shopping de BH')

    visit root_path
    click_on 'MG-Belo Horizonte'
    click_on 'Excluir'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão excluído com sucesso.')
    expect(page).not_to have_content('MG-Belo Horizonte' )
    expect(page).not_to have_content('BHS')
  end

  it 'e não apaga outros galpões' do 
    warehouse = Warehouse.create!(name: 'MG-Belo Horizonte', code: 'BHS', area: 65_0000, city: 'Belo Horizonte', 
      address: 'Av do Pão de Queijo, 44', cep:'23500-000', 
      description: 'Galpão do Shopping de BH')

    w = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 25_000, city: 'Cuiabá', 
                          address: 'Av Cuiaba, 44', cep:'25800-000', 
                          description: 'Galpão Central do Estado')

    visit root_path
    click_on 'MG-Belo Horizonte'
    click_on 'Excluir'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão excluído com sucesso.')
    expect(page).to have_content('Cuiaba')
    expect(page).to have_content('CWB')
  end
end