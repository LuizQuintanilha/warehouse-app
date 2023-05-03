require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do
    #arrange
    User.create!(name: 'Luiz Brito', email: 'luiz@email.com', password: 'password')
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
    expect(page).to have_button 'Sair'
    within('nav') do 
      expect(page).to have_content 'Luiz Brito - luiz@email.com'
    end
    expect(page).to have_content('Login efetuado com sucesso.')
  end

  it 'e faz logout ' do 
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
    click_on 'Sair'

    #assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_link 'luiz@email.com'
  end
end
