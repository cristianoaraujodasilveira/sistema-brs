feature "Official Diaries - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit official_diaries_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:official_diary)
      visit official_diaries_path
      expect(page).to have_content "Nome do Diário"
      expect(page).to have_content "Endereço Eletrônico"
      expect(page).to have_content "Esfera"
      expect(page).to have_content "Telefone BRS Cadastrado"
      expect(page).to have_content "Email BRS Cadastrado"
      expect(page).to have_content "Ações"
      expect(page).to have_link('Alterar')
      expect(page).to have_link('Excluir')
    end

    scenario "Filter by sphere", js:true do
      p1 = create(:official_diary)
      p2 = create(:official_diary)
      p3 = create(:official_diary)

      visit official_diaries_path
      select_from_chosen p1.sphere.name, :from => "official_diaries_grid[sphere_id]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by name", js:true do
      p1 = create(:official_diary, :name => 'Teste 1')
      p2 = create(:official_diary, :name => 'Teste 2')
      p3 = create(:official_diary, :name => 'Teste 3')

      visit official_diaries_path

      fill_in "official_diaries_grid[name]", with: p1.name

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Delete official_diary", js: true do
      create(:official_diary)
      visit official_diaries_path
      sleep 5
      first(:link, 'Excluir').click
      confirm
      expect(page).to have_content('Diário Oficial excluído com sucesso')
      expect(OfficialDiary.all.length).to eq 0
    end

  end

end
