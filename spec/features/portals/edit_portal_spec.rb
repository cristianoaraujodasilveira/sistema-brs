feature "Portal - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            portal = create :portal
            visit edit_portal_path portal
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
            portal = create :portal
            new_portal = build :portal
            responsible = build :responsible

            visit edit_portal_path portal

            fill_in "portal[name]", with: new_portal.name
            fill_in "portal[site]", with: new_portal.site
            fill_in "portal[email]", with: new_portal.email
            fill_in "portal[responsible]", with: new_portal.responsible
            fill_in "portal[registration_unit]", with: new_portal.registration_unit

            select_from_chosen new_portal.client.fantasy_name, :from => "portal[client_id]"

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
            expect(page).to have_content "Portal editado com sucesso"
            portal.reload

            expect(current_path).to eq edit_portal_path portal.id

            expect(portal.user_id).to_not eq user.id
            expect(portal.name).to eq new_portal.name
            expect(portal.site).to eq new_portal.site
            expect(portal.email).to eq new_portal.email

            expect(portal.responsible).to eq new_portal.responsible
            expect(portal.registration_unit).to eq new_portal.registration_unit
            expect(portal.client_id).to eq new_portal.client_id
            expect(portal.address.address).to eq 'Rua Moassy'

            expect(portal.observations[0].observation).to eq 'Observation'

            expect(portal.responsibles[0].name).to eq responsible.name
            expect(portal.responsibles[0].office).to eq responsible.office
            expect(portal.responsibles[0].department).to eq responsible.department
            expect(portal.responsibles[0].emails[0].email).to eq 'email'
            expect(portal.responsibles[0].skypes[0].skype).to eq 'skype'

        end

    end
end
