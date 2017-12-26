feature "bid_newspapers - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit bid_newspapers_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:bid_newspaper)
      visit bid_newspapers_path
      expect(page).to have_content "Nome do Jornal"
      expect(page).to have_content "Endereço Eletrônico"
      expect(page).to have_content "Parceiro"
      expect(page).to have_content "Nome do Responsável"
      expect(page).to have_content "Telefone Cadastrado"
      expect(page).to have_content "Email Cadastrado"
      expect(page).to have_content "Data de Início"
      expect(page).to have_content "Data de Término"
      expect(page).to have_content "Ações"
      expect(page).to have_link('Alterar')
      expect(page).to have_link('Excluir')
    end

    scenario "Filter by client", js:true do
      p1 = create(:bid_newspaper)
      p2 = create(:bid_newspaper)
      p3 = create(:bid_newspaper)

      visit bid_newspapers_path
      select_from_chosen p1.client.fantasy_name, :from => "bid_newspapers_grid[client_id]"

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by name", js:true do
      p1 = create(:bid_newspaper, :name => 'Teste 1')
      p2 = create(:bid_newspaper, :name => 'Teste 2')
      p3 = create(:bid_newspaper, :name => 'Teste 3')

      visit bid_newspapers_path

      fill_in "bid_newspapers_grid[name]", with: p1.name

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Filter by site", js:true do
      p1 = create(:bid_newspaper, :site => 'Teste 1')
      p2 = create(:bid_newspaper, :site => 'Teste 2')
      p3 = create(:bid_newspaper, :site => 'Teste 3')

      visit bid_newspapers_path

      fill_in "bid_newspapers_grid[site]", with: p1.site

      click_button "Filtrar"
      within("table.datagrid") do
        expect(page).to have_content p1.name
        expect(page).not_to have_content p2.name
        expect(page).not_to have_content p3.name
      end
    end

    scenario "Delete bid_newspaper", js: true do
      create(:bid_newspaper)
      visit bid_newspapers_path
      sleep 5
      first(:link, 'Excluir').click
      confirm
      expect(page).to have_content('Jornal de Licitação excluído com sucesso')
      expect(BidNewspaper.all.length).to eq 0
    end

  end

end
