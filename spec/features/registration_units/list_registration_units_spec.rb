feature "Registration Units - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit registration_units_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:registration_unit)
      visit registration_units_path
      expect(current_path).to eq registration_units_path
    end

  #   scenario "Default List" do
  #     create(:registration_unit)
  #     visit registration_units_path
  #     expect(page).to have_content "Nome da unidade"
  #     expect(page).to have_content "Orgão"
  #     expect(page).to have_content "Site"
  #     expect(page).to have_content "Email"
  #     expect(page).to have_content "Telefone"
  #     expect(page).to have_content "Responsável"
  #     expect(page).to have_content "Ações"
  #     expect(page).to have_link('Ver todos')
  #     expect(page).to have_link('Editar')
  #     expect(page).to have_link('Excluir')
  #   end

  #   scenario "Default List - With responsibles", js: true do
  #     create(:registration_unit, :with_responsibles)
  #     visit registration_units_path
  #     click_link('Ver todos')
  #     sleep 1
  #     expect(page).to have_content "Responsável"
  #     expect(page).to have_content "Cargo/Função"
  #     expect(page).to have_content "Departamento"
  #     expect(page).to have_content "Whatsapp"
  #     expect(page).to have_content "Skype"
  #     expect(page).to have_content "Email"
  #     expect(page).to have_content "Telefone"
  #     expect(page).to have_link(:href=>"/registration_units/2/edit")
  #     expect(page).to have_link(:href=>"/delete_responsible_registration_unit.1")
  #   end

  #   scenario "Delete registration unit - with responsibles", js: true do
  #     create(:registration_unit, :with_responsibles)
  #     visit registration_units_path
  #     click_link('Excluir')
  #     confirm
  #     expect(page).to have_content('Unidade de cadastramento excluída com sucesso')
  #     expect(RegistrationUnit.all.length).to eq 0
  #     expect(ResponsibleRegistrationUnit.all.length).to eq 0
  #   end

  #   scenario "Delete registration unit - with branchs", js: true do
  #     create(:registration_unit, :with_units)
  #     visit registration_units_path
  #     first(:link, 'Excluir').click
  #     confirm
  #     expect(page).to have_content('Unidade de cadastramento excluída com sucesso')
  #     expect(RegistrationUnit.all.length).to eq 0
  #   end

  #   scenario "Delete responsible", js: true do
  #     create(:registration_unit, :with_responsibles)
  #     visit registration_units_path
  #     first(:link, 'Ver todos').click
  #     sleep 1
  #     click_link(:href=>"/delete_responsible_registration_unit.1")
  #     confirm
  #     expect(page).to have_content('Responsável excluído com sucesso')
  #     expect(RegistrationUnit.all.length).to eq 1
  #     expect(ResponsibleRegistrationUnit.all.length).to eq 0
  #   end
end

end
