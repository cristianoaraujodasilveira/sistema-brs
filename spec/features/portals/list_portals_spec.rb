feature "Portals - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit portals_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:portal)
      visit portals_path
      expect(page).to have_content "Nome do Portal"
      expect(page).to have_content "Endereço Eletrônico"
      expect(page).to have_content "Parceiro"
      expect(page).to have_content "Responsável pelo Cadastro"
      expect(page).to have_content "Nome do Responsável"
      expect(page).to have_content "Telefone do Responsável"
      expect(page).to have_content "Email do Responsável"
      expect(page).to have_content "Ações"
      expect(page).to have_link('Alterar')
      expect(page).to have_link('Excluir')
    end

    scenario "Filter by client", js:true do
      p1 = create(:portal)
      p2 = create(:portal)
      p3 = create(:portal)

      visit portals_path
      select_from_chosen p1.client.fantasy_name, :from => "portals_grid[client_id]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by name", js:true do
      p1 = create(:portal, :name => 'Teste 1')
      p2 = create(:portal, :name => 'Teste 2')
      p3 = create(:portal, :name => 'Teste 3')

      visit portals_path

      fill_in "portals_grid[name]", with: p1.name

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by site", js:true do
      p1 = create(:portal, :site => 'Teste 1')
      p2 = create(:portal, :site => 'Teste 2')
      p3 = create(:portal, :site => 'Teste 3')

      visit portals_path

      fill_in "portals_grid[site]", with: p1.site

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Delete portal", js: true do
      create(:portal)
      visit portals_path
      sleep 5
      first(:link, 'Excluir').click
      confirm
      expect(page).to have_content('Portal excluído com sucesso')
      expect(Portal.all.length).to eq 0
    end

  end

end
