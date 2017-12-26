feature "Proposal - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            proposal = create(:proposal)
            visit edit_proposal_path proposal
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            proposal = create :proposal
            visit edit_proposal_path proposal
            expect(current_path).to eq edit_proposal_path proposal
        end

        # scenario "Success", js: true do
        #     proposal = create :proposal
        #     proposal_new = build :proposal
        #     create_list(:client, 2)
        #     create(:monthly_value)

        #     visit edit_proposal_path proposal
        #     sleep 1
        #     select_from_chosen User.last.name, :from => "proposal[user_ids][]"
        #     select_from_chosen ProposalSituation.first.name, :from => "proposal[proposal_situation_id]"
        #     # select_from_chosen Client.first.social_name, :from => "proposal[client_id]"

        #     fill_in "proposal[title]", with: proposal_new.title
        #     fill_in "proposal[observation]", with: proposal_new.observation
        #     fill_in "proposal[notes]", with: proposal_new.notes

        #     fill_in "proposal[cnpj]", with: "65.560.646/0001-79"
        #     fill_in "proposal[fantasy_name]", with: proposal_new.fantasy_name
        #     fill_in "proposal[social_name]", with: proposal_new.social_name

        #     fill_in "proposal[proposed_value]", with: proposal_new.proposed_value
        #     fill_in "proposal[closed_value]", with: proposal_new.closed_value
        #     fill_in "proposal[minimum_value]", with: proposal_new.minimum_value
        #     fill_in "proposal[proposed_percentage]", with: proposal_new.proposed_percentage
        #     fill_in "proposal[closed_percentage]", with: proposal_new.closed_percentage
        #     fill_in "proposal[minimum_percentage]", with: proposal_new.minimum_percentage
        #     fill_in "proposal[commission_percentage]", with: proposal_new.commission_percentage

        #     fill_in "proposal[monthly_values_attributes][0][percentual_discounts]", with: MonthlyValue.first.percentual_discounts
        #     fill_in "proposal[monthly_values_attributes][0][observation]", with: MonthlyValue.first.observation  

        #     attach_file 'proposal[upload_proposals_attributes][0][file]', "#{Rails.root}/spec/support/files/arquivo.pdf"

        #     click_button "Salvar" 
        #     sleep 1

        #     expect(page).to have_content "Proposta editada com sucesso"
        #     expect(current_path).to eq edit_proposal_path proposal

        #     expect(Proposal.first.user_ids[1]).to eq User.last.id
        #     expect(Proposal.first.proposal_situation_id).to eq ProposalSituation.first.id
        #     # expect(Proposal.first.client_id).to eq Client.first.id

        #     expect(Proposal.first.cnpj).to eq "65.560.646/0001-79"
        #     expect(Proposal.first.fantasy_name).to eq proposal_new.fantasy_name
        #     expect(Proposal.first.social_name).to eq proposal_new.social_name

        #     expect(Proposal.first.proposed_value).to eq proposal_new.proposed_value
        #     expect(Proposal.first.closed_value).to eq proposal_new.closed_value
        #     expect(Proposal.first.minimum_value).to eq proposal_new.minimum_value
        #     expect(Proposal.first.proposed_percentage).to eq proposal_new.proposed_percentage
        #     expect(Proposal.first.closed_percentage).to eq proposal_new.closed_percentage
        #     expect(Proposal.first.minimum_percentage).to eq proposal_new.minimum_percentage
        #     expect(Proposal.first.commission_percentage).to eq proposal_new.commission_percentage

        #     expect(Proposal.first.monthly_values[0].percentual_discounts).to eq MonthlyValue.first.percentual_discounts
        #     expect(Proposal.first.monthly_values[0].observation).to eq MonthlyValue.first.observation

        #     expect(Proposal.first.upload_proposals[0].file_file_name).to eq "arquivo.pdf"
        # end

    end
end
