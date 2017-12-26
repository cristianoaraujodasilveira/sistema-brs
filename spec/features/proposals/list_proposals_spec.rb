feature "Proposals - List" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit proposals_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user }

        background do
            login user.email, user.password
        end

        scenario "Default List" do
            create(:proposal)
            visit proposals_path
            expect(current_path).to eq proposals_path
        end


# scenario "Default List" do
#   create(:proposal)
#   visit proposals_path
#   expect(page).to have_content "Razão Social"
#   expect(page).to have_content "CNPJ"
#   expect(page).to have_content "Usuário responsável"
#   expect(page).to have_content "Título da proposta"
#   expect(page).to have_content "Observações gerais"
#   expect(page).to have_content "Situação"
#   expect(page).to have_content "Ações"
#   expect(page).to have_link('Histórico')
#   expect(page).to have_link('Alterar')
#   expect(page).to have_link('Excluir')
# end

# scenario "Filter by situation", js:true do
#   p1 = create(:proposal)
#   p2 = create(:proposal)
#   p3 = create(:proposal)

#   visit proposals_path
#   select ProposalSituation.first.name, :from => "proposals_grid[proposal_situation_id]"

#   click_button "Filtrar"
#   within("table.datagrid") do
#     expect(page).to have_content p1.title
#     expect(page).not_to have_content p2.title
#     expect(page).not_to have_content p3.title
#   end
# end

# scenario "Filter by created_at", js:true do
#   prop1 = create :proposal, :created_at => '2015-06-02 10:10:10'
#   prop2 = create :proposal, :created_at => '2015-06-03 10:10:10'
#   prop3 = create :proposal, :created_at => '2015-06-04 10:10:10'

#   visit proposals_path

#   page.execute_script("$('.created_at.date_filter.from').val('01/06/2015')")
#   page.execute_script("$('.created_at.date_filter.to').val('03/06/2015')")
#   click_button "Filtrar"

#   within("table.datagrid") do
#     expect(page).to have_content prop1.title
#     expect(page).to have_content prop2.title
#     expect(page).not_to have_content prop3.title
#   end
# end

# scenario "Delete proposal", js: true do
#   create(:proposal)
#   visit proposals_path
#   first(:link, 'Excluir').click
#   confirm
#   expect(page).to have_content('Proposta excluída com sucesso')
#   expect(Proposal.all.length).to eq 0
# end
end

end
