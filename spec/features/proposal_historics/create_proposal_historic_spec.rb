feature "Proposal Historic - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            create(:proposal)
            visit proposals_historic_path 1
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}
        let(:user_2) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            proposal = create :proposal
            visit proposals_historic_path proposal
            expect(current_path).to eq proposals_historic_path proposal
        end

        # scenario "Success", js: true do
        #     proposal = create :proposal
        #     create_list(:proposal_historic, 5, :proposal => proposal)
        #     proposal_historic_1 = create(:proposal_historic)
        #     proposal_historic_2 = create(:proposal_historic)

        #     visit proposals_historic_path proposal

        #     fill_in "proposal[proposal_historics_attributes][5][comment]", with: proposal_historic_1.comment

        #     click_button "Salvar" 
        #     sleep 1
        #     expect(Proposal.first.proposal_historics.length).to eq 6
        #     expect(ProposalHistoric.last.comment).to eq proposal_historic_1.comment
        #     expect(ProposalHistoric.last.user_id).to eq user.id
        #     sleep 5

        #     logout
        #     sleep 1

        #     login user_2.email, user_2.password

        #     visit proposals_historic_path proposal

        #     fill_in "proposal[proposal_historics_attributes][6][comment]", with: proposal_historic_2.comment

        #     click_button "Salvar" 
        #     sleep 1
        #     expect(Proposal.first.proposal_historics.length).to eq 7
        #     expect(ProposalHistoric.last.comment).to eq proposal_historic_2.comment
        #     expect(ProposalHistoric.last.user_id).to eq user_2.id

        # end

    end
end
