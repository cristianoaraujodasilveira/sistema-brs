require "rails_helper"

feature "Login" do

  scenario 'invalid', js: true do
    login('bbbb@bbb.bbb', 'aaaaaaa')
    expect(page).to have_content "Usuário não encontrado"
  end

  scenario "success" , js: true do
    adm = create(:user)
    login(adm.email, adm.password)
    expect(current_path).to eq calendar_events_path
    expect(page).to have_content "Bem vindo!"
  end

end
