feature "Bid Newspaper - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_bid_newspaper_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success", js:true do
            bid_newspaper = build :bid_newspaper
            responsible = build :responsible

            visit new_bid_newspaper_path
            fill_in "bid_newspaper[name]", with: bid_newspaper.name
            fill_in "bid_newspaper[initial_date]", with: '26/09/1990'
            fill_in "bid_newspaper[final_date]", with: '26/09/1990'
            fill_in "bid_newspaper[site]", with: bid_newspaper.site
            fill_in "bid_newspaper[email_brs]", with: bid_newspaper.email_brs
            fill_in "bid_newspaper[social_name]", with: bid_newspaper.social_name
            fill_in "bid_newspaper[cnpj]", with: bid_newspaper.cnpj

            select_from_chosen bid_newspaper.client.fantasy_name, :from => "bid_newspaper[client_id]"

            fill_in "bid_newspaper[observations_attributes][1][observation]", with: 'Observation'

            fill_in "bid_newspaper[responsibles_attributes][0][name]", with: responsible.name
            fill_in "bid_newspaper[responsibles_attributes][0][office]", with: responsible.office
            fill_in "bid_newspaper[responsibles_attributes][0][department]", with: responsible.department
            fill_in "bid_newspaper[responsibles_attributes][0][emails_attributes][0][email]", with: 'email'
            fill_in "bid_newspaper[responsibles_attributes][0][skypes_attributes][0][skype]", with: 'skype'

            click_button "Salvar" 
            sleep 1
            expect(page).to have_content "Jornal de Licitação cadastrado com sucesso"

            expect(current_path).to eq edit_bid_newspaper_path BidNewspaper.last.id

            bid_newspaper_last = BidNewspaper.last
            expect(bid_newspaper_last.name).to eq bid_newspaper.name
            expect(bid_newspaper_last.user_id).to eq user.id
            expect(bid_newspaper_last.site).to eq bid_newspaper.site
            expect(bid_newspaper_last.email_brs).to eq bid_newspaper.email_brs

            expect(bid_newspaper_last.social_name).to eq bid_newspaper.social_name
            expect(bid_newspaper_last.cnpj).to eq bid_newspaper.cnpj
            expect(bid_newspaper_last.client_id).to eq bid_newspaper.client_id

            expect(bid_newspaper_last.observations[0].observation).to eq 'Observation'

            expect(bid_newspaper_last.responsibles[0].name).to eq responsible.name
            expect(bid_newspaper_last.responsibles[0].office).to eq responsible.office
            expect(bid_newspaper_last.responsibles[0].department).to eq responsible.department
            expect(bid_newspaper_last.responsibles[0].emails[0].email).to eq 'email'
            expect(bid_newspaper_last.responsibles[0].skypes[0].skype).to eq 'skype'

        end

        scenario "invalid fields", js:true do
            visit new_bid_newspaper_path
            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Nome do Jornal não pode ficar em branco"
            expect(page).to have_content "Parceiro não pode ficar em branco"
            expect(page).to have_content "Data de Início não pode ficar em branco"
            expect(page).to have_content "Data de Término não pode ficar em branco"
            expect(page).to have_content "Razão Social não pode ficar em branco"
            expect(page).to have_content "CNPJ não pode ficar em branco"
        end
    end
end
