feature "Bid Newspaper - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            bid_newspaper = create :bid_newspaper
            visit edit_bid_newspaper_path bid_newspaper
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success", js:true do
            bid_newspaper = create :bid_newspaper
            new_bid_newspaper = build :bid_newspaper
            responsible = build :responsible

            visit edit_bid_newspaper_path bid_newspaper
            fill_in "bid_newspaper[name]", with: new_bid_newspaper.name
            fill_in "bid_newspaper[initial_date]", with: '26/09/1990'
            fill_in "bid_newspaper[final_date]", with: '26/09/1990'
            fill_in "bid_newspaper[site]", with: new_bid_newspaper.site
            fill_in "bid_newspaper[email_brs]", with: new_bid_newspaper.email_brs
            fill_in "bid_newspaper[social_name]", with: new_bid_newspaper.social_name
            fill_in "bid_newspaper[cnpj]", with: new_bid_newspaper.cnpj

            select_from_chosen new_bid_newspaper.client.fantasy_name, :from => "bid_newspaper[client_id]"

            fill_in "bid_newspaper[observations_attributes][1][observation]", with: 'Observation'

            fill_in "bid_newspaper[responsibles_attributes][0][name]", with: responsible.name
            fill_in "bid_newspaper[responsibles_attributes][0][office]", with: responsible.office
            fill_in "bid_newspaper[responsibles_attributes][0][department]", with: responsible.department
            fill_in "bid_newspaper[responsibles_attributes][0][emails_attributes][0][email]", with: 'email'
            fill_in "bid_newspaper[responsibles_attributes][0][skypes_attributes][0][skype]", with: 'skype'

            click_button "Salvar" 
            sleep 1
            expect(page).to have_content "Jornal de Licitação editado com sucesso"

            bid_newspaper.reload

            expect(current_path).to eq edit_bid_newspaper_path bid_newspaper.id

            expect(bid_newspaper.name).to eq new_bid_newspaper.name
            expect(bid_newspaper.user_id).to_not eq user.id
            expect(bid_newspaper.site).to eq new_bid_newspaper.site
            expect(bid_newspaper.email_brs).to eq new_bid_newspaper.email_brs

            expect(bid_newspaper.social_name).to eq new_bid_newspaper.social_name
            expect(bid_newspaper.cnpj).to eq new_bid_newspaper.cnpj
            expect(bid_newspaper.client_id).to eq new_bid_newspaper.client_id

            expect(bid_newspaper.observations[0].observation).to eq 'Observation'

            expect(bid_newspaper.responsibles[0].name).to eq responsible.name
            expect(bid_newspaper.responsibles[0].office).to eq responsible.office
            expect(bid_newspaper.responsibles[0].department).to eq responsible.department
            expect(bid_newspaper.responsibles[0].emails[0].email).to eq 'email'
            expect(bid_newspaper.responsibles[0].skypes[0].skype).to eq 'skype'

        end

    end
end
