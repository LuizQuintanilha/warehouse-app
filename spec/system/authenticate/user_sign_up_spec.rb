require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # arrange

    # act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Luana'
    fill_in 'E-mail', with: 'luana@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar conta'

    # assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'luana@email.com'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Luana'
  end
end
