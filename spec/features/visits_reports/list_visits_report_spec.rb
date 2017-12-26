feature "Visits Reports - List" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit visits_reports_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user }

    background do
      login user.email, user.password
    end

    scenario "Default List" do
      create(:visits_report)
      visit visits_reports_path
      expect(current_path).to eq visits_reports_path
    end

  #   scenario "Default List" do
  #     create(:visits_report)
  #     visit visits_reports_path
  #     expect(page).to have_content "Nº da visita"
  #     expect(page).to have_content "Razão social"
  #     expect(page).to have_content "CNPJ"
  #     expect(page).to have_content "Contato responsável"
  #     expect(page).to have_content "Proposta"
  #     expect(page).to have_content "Usuário responsável"
  #     expect(page).to have_content "Data"
  #     expect(page).to have_content "Assunto"
  #     expect(page).to have_link('Alterar')
  #     expect(page).to have_link('Excluir')
  #   end

  #   scenario "Filter by social name", js:true do
  #     p1 = create(:visits_report, :social_name => "text 1")
  #     p2 = create(:visits_report, :social_name => "text 2")
  #     p3 = create(:visits_report, :social_name => "text 2")

  #     visit visits_reports_path
  #     fill_in "visits_reports_grid[social_name]", with: "text 1"

  #     click_button "Filtrar"
  #     within("table.datagrid") do
  #       expect(page).to have_content p1.social_name
  #       expect(page).not_to have_content p2.social_name
  #       expect(page).not_to have_content p3.social_name
  #     end
  #   end

  #   scenario "Filter by social name", js:true do
  #     p1 = create(:visits_report, :proposal_text => "text 1")
  #     p2 = create(:visits_report, :proposal_text => "text 2")
  #     p3 = create(:visits_report, :proposal_text => "text 2")

  #     visit visits_reports_path
  #     fill_in "visits_reports_grid[proposal_text]", with: "text 1"

  #     click_button "Filtrar"
  #     within("table.datagrid") do
  #       expect(page).to have_content p1.social_name
  #       expect(page).not_to have_content p2.social_name
  #       expect(page).not_to have_content p3.social_name
  #     end
  #   end

  #   scenario "Filter by User Responsible", js:true do
  #     p1 = create(:visits_report)
  #     p2 = create(:visits_report)
  #     p3 = create(:visits_report)

  #     visit visits_reports_path
  #     select p1.user.name, :from => "visits_reports_grid[user_id]"

  #     click_button "Filtrar"
  #     within("table.datagrid") do
  #       expect(page).to have_content p1.social_name
  #       expect(page).not_to have_content p2.social_name
  #       expect(page).not_to have_content p3.social_name
  #     end
  #   end

  #   scenario "Filter by date_and_time", js:true do
  #     p1 = create :visits_report, :date_and_time => '2015-06-10 10:10:10'
  #     p2 = create :visits_report, :date_and_time => '2015-06-11 10:10:10'
  #     p3 = create :visits_report, :date_and_time => '2015-06-13 10:10:10'

  #     visit visits_reports_path

  #     page.execute_script("$('.date_and_time.date_filter.from').val('10/06/2015')")
  #     page.execute_script("$('.date_and_time.date_filter.to').val('12/06/2015')")
  #     click_button "Filtrar"

  #     within("table.datagrid") do
  #       expect(page).to have_content p1.social_name
  #       expect(page).to have_content p2.social_name
  #       expect(page).not_to have_content p3.social_name
  #     end
  #   end

  #   scenario "Delete Visits Reports", js: true do
  #     create(:visits_report)
  #     visit visits_reports_path
  #     first(:link, 'Excluir').click
  #     confirm
  #     expect(page).to have_content('Relatório da visita excluído com sucesso')
  #     expect(VisitsReport.all.length).to eq 0
  #   end
end

end
