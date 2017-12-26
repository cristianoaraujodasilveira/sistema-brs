feature "Users - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit users_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    # scenario "Default List" do
    #   create(:user)
    #   visit users_path
    #   expect(current_path).to eq users_path
    # end

  #   scenario "Default List" do
  #     create(:user)
  #     visit users_path
  #     expect(page).to have_content "Tipo"
  #     expect(page).to have_content "Nome completo"
  #     expect(page).to have_content "Email"
  #     expect(page).to have_content "Senha"
  #     expect(page).to have_content "Último acesso"
  #     expect(page).to have_content "Ações"
  #     expect(page).to have_link('Editar')
  #     expect(page).to have_link('Excluir')
  #     expect(page).to have_link('Histórico')
  #   end

  #   scenario "Delete", js: true do
  #     create :user, :id => 5
  #     visit users_path
  #     find(:xpath, "//a[@href='/users/5']").click
  #     confirm
  #     expect(page).to have_content('Usuário excluído com sucesso')
  #     expect(User.all.length).to eq 1
  #   end
end

end
