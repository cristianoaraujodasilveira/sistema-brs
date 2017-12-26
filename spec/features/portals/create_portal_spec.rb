feature "Portal - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_portal_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)
        end

        scenario "Success", js:true do
            portal = build :portal
            responsible = build :responsible

            visit new_portal_path
            fill_in "portal[name]", with: portal.name
            fill_in "portal[initial_date]", with: '26/09/1990'
            fill_in "portal[final_date]", with: '26/09/1990'
            fill_in "portal[site]", with: portal.site
            fill_in "portal[email]", with: portal.email
            fill_in "portal[responsible]", with: portal.responsible
            fill_in "portal[registration_unit]", with: portal.registration_unit

            select_from_chosen portal.client.fantasy_name, :from => "portal[client_id]"

            fill_in "portal[address_attributes][zipcode]", with: '32.341-170'
            fill_in "portal[address_attributes][number]", with: '240'
            sleep 5

            fill_in "portal[observations_attributes][1][observation]", with: 'Observation'

            fill_in "portal[responsibles_attributes][0][name]", with: responsible.name
            fill_in "portal[responsibles_attributes][0][office]", with: responsible.office
            fill_in "portal[responsibles_attributes][0][department]", with: responsible.department
            fill_in "portal[responsibles_attributes][0][emails_attributes][0][email]", with: 'email'
            fill_in "portal[responsibles_attributes][0][skypes_attributes][0][skype]", with: 'skype'

            click_button "Salvar" 
            sleep 1
            expect(page).to have_content "Portal cadastrado com sucesso"

            expect(current_path).to eq edit_portal_path Portal.last.id

            portal_last = Portal.last
            expect(portal_last.name).to eq portal.name
            expect(portal_last.user_id).to eq user.id
            expect(portal_last.site).to eq portal.site
            expect(portal_last.email).to eq portal.email

            expect(portal_last.responsible).to eq portal.responsible
            expect(portal_last.registration_unit).to eq portal.registration_unit
            expect(portal_last.client_id).to eq portal.client_id
            expect(portal_last.address.address).to eq 'Rua Moassy'

            expect(portal_last.observations[0].observation).to eq 'Observation'

            expect(portal_last.responsibles[0].name).to eq responsible.name
            expect(portal_last.responsibles[0].office).to eq responsible.office
            expect(portal_last.responsibles[0].department).to eq responsible.department
            expect(portal_last.responsibles[0].emails[0].email).to eq 'email'
            expect(portal_last.responsibles[0].skypes[0].skype).to eq 'skype'

        end

        scenario "invalid fields", js:true do
            visit new_portal_path
            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Nome do Portal não pode ficar em branco"
            expect(page).to have_content "Parceiro não pode ficar em branco"
            expect(page).to have_content "Data de Início não pode ficar em branco"
            expect(page).to have_content "Data de Término não pode ficar em branco"
            expect(page).to have_content "Responsável pelo Cadastro não pode ficar em branco"
            expect(page).to have_content "Unidade Cadastradora não pode ficar em branco"
        end
    end
end
