feature "Contracts - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit contracts_path
      expect(current_path).to eq new_session_path
    end
  end

  # context 'Admin' do
  #   let(:user) { create :user }

  #   background do
  #     login user.email, user.password
  #   end

  #   scenario "Default List" do
  #     create(:contract)
  #     visit contracts_path
  #     expect(page).to have_content "Razão social"
  #     expect(page).to have_content "CNPJ"
  #     expect(page).to have_content "Usuário responsável"
  #     expect(page).to have_content "Telefone"
  #     expect(page).to have_content "Data de início do contrato"
  #     expect(page).to have_link('Visualizar')
  #   end

  #   scenario "Filter by client", js:true do
  #     p1 = create(:contract)
  #     p2 = create(:contract)
  #     p3 = create(:contract)

  #     visit contracts_path
  #     select p1.client.social_name, :from => "contracts_grid[client_id]"

  #     click_button "Filtrar"
  #     within("table.datagrid") do
  #       expect(page).to have_content p1.client.social_name
  #       expect(page).not_to have_content p2.client.social_name
  #       expect(page).not_to have_content p3.client.social_name
  #     end
  #   end

  #   scenario "Filter by responsible", js:true do
  #     p1 = create :contract
  #     p2 = create :contract
  #     p3 = create :contract

  #     visit contracts_path

  #     select p1.users[0].name, :from => "contracts_grid[user_id]"

  #     click_button "Filtrar"

  #     within("table.datagrid") do
  #       expect(page).to have_content p1.client.social_name
  #       expect(page).not_to have_content p2.client.social_name
  #       expect(page).not_to have_content p3.client.social_name
  #     end
  #   end

  #   scenario "Filter by created_at", js:true do
  #     prop1 = create :contract, :pre_established_initial_date => '2015-06-02'
  #     prop2 = create :contract, :pre_established_initial_date => '2015-06-03'
  #     prop3 = create :contract, :pre_established_initial_date => '2015-06-04'

  #     visit contracts_path

  #     page.execute_script("$('.pre_established_initial_date.date_filter.from').val('01/06/2015')")
  #     page.execute_script("$('.pre_established_initial_date.date_filter.to').val('03/06/2015')")
  #     click_button "Filtrar"

  #     within("table.datagrid") do
  #       expect(page).to have_content prop1.client.social_name
  #       expect(page).to have_content prop2.client.social_name
  #       expect(page).not_to have_content prop3.client.social_name
  #     end
  #   end
  # end

end
