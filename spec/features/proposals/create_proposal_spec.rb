feature "Proposal - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_proposal_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            visit new_proposal_path
            expect(current_path).to eq new_proposal_path
        end

        # scenario "Success", js: true do
        #     proposal = (build :proposal)
        #     create_list(:user, 2)
        #     create_list(:client, 2)
        #     create(:monthly_value)

        #     visit new_proposal_path
        #     sleep 1
        #     select_from_chosen User.last.name, :from => "proposal[user_ids][]"
        #     select_from_chosen ProposalSituation.first.name, :from => "proposal[proposal_situation_id]"
        #     # select_from_chosen Client.first.social_name, :from => "proposal[client_id]"

        #     fill_in "proposal[title]", with: proposal.title
        #     fill_in "proposal[observation]", with: proposal.observation
        #     fill_in "proposal[notes]", with: proposal.notes

        #     fill_in "proposal[cnpj]", with: "65.560.646/0001-79"
        #     fill_in "proposal[fantasy_name]", with: proposal.fantasy_name
        #     fill_in "proposal[social_name]", with: proposal.social_name

        #     fill_in "proposal[proposed_value]", with: proposal.proposed_value
        #     fill_in "proposal[closed_value]", with: proposal.closed_value
        #     fill_in "proposal[minimum_value]", with: proposal.minimum_value
        #     fill_in "proposal[proposed_percentage]", with: proposal.proposed_percentage
        #     fill_in "proposal[closed_percentage]", with: proposal.closed_percentage
        #     fill_in "proposal[minimum_percentage]", with: proposal.minimum_percentage
        #     fill_in "proposal[commission_percentage]", with: proposal.commission_percentage

        #     fill_in "proposal[monthly_values_attributes][0][percentual_discounts]", with: MonthlyValue.first.percentual_discounts
        #     fill_in "proposal[monthly_values_attributes][0][observation]", with: MonthlyValue.first.observation  

        #     attach_file 'proposal[upload_proposals_attributes][0][file]', "#{Rails.root}/spec/support/files/arquivo.pdf"

        #     click_button "Salvar" 
        #     sleep 1

        #     expect(page).to have_content "Proposta cadastrada com sucesso"
        #     expect(current_path).to eq proposals_path

        #     expect(Proposal.last.user_ids[0]).to eq User.last.id
        #     expect(Proposal.last.proposal_situation_id).to eq ProposalSituation.first.id
        #     # expect(Proposal.last.client_id).to eq Client.first.id

        #     expect(Proposal.last.cnpj).to eq "65.560.646/0001-79"
        #     expect(Proposal.last.fantasy_name).to eq proposal.fantasy_name
        #     expect(Proposal.last.social_name).to eq proposal.social_name
        
        #     expect(Proposal.last.proposed_value).to eq proposal.proposed_value
        #     expect(Proposal.last.closed_value).to eq proposal.closed_value
        #     expect(Proposal.last.minimum_value).to eq proposal.minimum_value
        #     expect(Proposal.last.proposed_percentage).to eq proposal.proposed_percentage
        #     expect(Proposal.last.closed_percentage).to eq proposal.closed_percentage
        #     expect(Proposal.last.minimum_percentage).to eq proposal.minimum_percentage
        #     expect(Proposal.last.commission_percentage).to eq proposal.commission_percentage

        #     expect(Proposal.last.monthly_values[0].percentual_discounts).to eq MonthlyValue.first.percentual_discounts
        #     expect(Proposal.last.monthly_values[0].observation).to eq MonthlyValue.first.observation

        #     expect(Proposal.last.upload_proposals[0].file_file_name).to eq "arquivo.pdf"
        # end

        # scenario "invalid fields", js: true do
        #     visit new_proposal_path
        #     click_button "Salvar"
        #     sleep 1

        #     expect(page).to have_content "Razão Social não pode ficar em branco"
        #     expect(page).to have_content "Proposto (Valor) não pode ficar em branco"
        #     expect(page).to have_content "Fechado (Valor) não pode ficar em branco"
        #     expect(page).to have_content "Mínimo (Valor) não pode ficar em branco"
        #     expect(page).to have_content "Proposto (Percentual) não pode ficar em branco"
        #     expect(page).to have_content "Fechado (Percentual) não pode ficar em branco"
        # end
    end
end
