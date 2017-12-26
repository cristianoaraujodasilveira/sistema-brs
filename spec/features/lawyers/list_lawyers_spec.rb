feature "Lawyers - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit lawyers_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:lawyer)
      visit lawyers_path
      expect(page).to have_content "Nome"
      expect(page).to have_content "OAB"
      expect(page).to have_content "Tipo"
      expect(page).to have_content "Cidade"
      expect(page).to have_content "Estado"
      expect(page).to have_content "Ações"
      expect(page).to have_link('Alterar')
      expect(page).to have_link('Excluir')
    end

    scenario "Filter by name", js:true do
      p1 = create(:lawyer, :name => 'Teste 1')
      p2 = create(:lawyer, :name => 'Teste 2')
      p3 = create(:lawyer, :name => 'Teste 3')

      visit lawyers_path

      fill_in "lawyers_grid[name]", with: p1.name

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by lawyer type", js:true do
      p1 = create(:lawyer)
      p2 = create(:lawyer)
      p3 = create(:lawyer)

      visit lawyers_path
      select_from_chosen p1.lawyer_type.name, :from => "lawyers_grid[lawyer_type]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by lawyer city", js:true do
      p1 = create(:lawyer)
      p2 = create(:lawyer)
      p3 = create(:lawyer)

      visit lawyers_path
      select_from_chosen p1.city.name, :from => "lawyers_grid[city]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by lawyer state", js:true do
      state = create(:state, :acronym => "AA")
      p1 = create(:lawyer, state: state)
      p2 = create(:lawyer)
      p3 = create(:lawyer)

      visit lawyers_path
      select_from_chosen p1.state.acronym, :from => "lawyers_grid[state]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Delete lawyer", js: true do
      create(:lawyer)
      visit lawyers_path
      sleep 5
      first(:link, 'Excluir').click
      confirm
      expect(page).to have_content('Advogado excluído com sucesso')
      expect(Lawyer.all.length).to eq 0
    end

  end

end
