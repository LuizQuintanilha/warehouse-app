require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do
    #arrange
    User.create!(email: 'luiz@email.com', password: 'password')
    #act
    visit root_path
    click_on 'Entrar'
    within('form') do 
      fill_in 'E-mail', with: 'luiz@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    #assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    within('nav') do 
      expect(page).to have_content 'luiz@email.com'
    end
    expect(page).to have_content('Login efetuado com sucesso.')
  end
end
