require 'rails_helper'

describe 'User see datails ' do 
  it 'and delete warehouse' do 

    warehouse = Warehouse.create!(name: 'MG-Belo Horizonte', code: 'BHS', area: 65_0000, city: 'Belo Horizonte', 
                                  address: 'Av do Pão de Queijo, 44', cep:'23500-000', 
                                  description: 'Galpão do Shopping de BH')

    visit root_path
    click_on 'MG-Belo Horizonte'
    click_on 'Excluir'

    expect(page).to have_content('Galpão excluído com sucesso.')

  end

end