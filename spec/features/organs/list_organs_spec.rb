feature "Organs - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit organs_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:organ)
      visit organs_path
      expect(page).to have_content "N. do Orgão"
      expect(page).to have_content "Orgão"
      expect(page).to have_content "CNPJ"
      expect(page).to have_content "Telefone geral"
      expect(page).to have_content "Esfera"
      expect(page).to have_content "Identificação do orgão"
      expect(page).to have_content "Setor"
      expect(page).to have_content "Ações"
      expect(page).to have_link('Ver todos')
      expect(page).to have_link('Editar')
      expect(page).to have_link('Excluir')
    end

    # scenario "Default List - With sector", js: true do
    #   create(:organ, :with_sectors)
    #   visit organs_path
    #   click_link('Ver todos')
    #   sleep 1
    #   expect(page).to have_content "Nome do setor"
    #   expect(page).to have_content "Responsável"
    #   expect(page).to have_content "Cargo"
    #   expect(page).to have_content "Email"
    #   expect(page).to have_content "Telefone"
    #   expect(page).to have_link(:href=>"/organs/2/edit")
    #   expect(page).to have_link(:href=>"/delete_sector.1")
    # end

    # scenario "Delete organ - with sectors", js: true do
    #   create(:organ, :with_sectors)
    #   visit organs_path
    #   first(:link, 'Excluir').click
    #   confirm
    #   expect(page).to have_content('Orgão excluído com sucesso')
    #   expect(Organ.all.length).to eq 0
    #   expect(Sector.all.length).to eq 0
    # end

    # scenario "Delete organ - with branchs", js: true do
    #   create(:organ, :with_branchs)
    #   visit organs_path
    #   first(:link, 'Excluir').click
    #   confirm
    #   expect(page).to have_content('Orgão excluído com sucesso')
    #   expect(Organ.all.length).to eq 0
    # end

    # scenario "Delete sector", js: true do
    #   create(:organ, :with_sectors)
    #   visit organs_path
    #   first(:link, 'Ver todos').click
    #   sleep 1
    #   click_link(:href=>"/delete_sector.1")
    #   confirm
    #   expect(page).to have_content('Setor excluído com sucesso')
    #   expect(Organ.all.length).to eq 1
    #   expect(Sector.all.length).to eq 0
    # end
  end

end
