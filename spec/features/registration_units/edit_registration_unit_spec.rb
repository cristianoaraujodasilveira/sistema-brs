feature "Registration Unit - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            registration_unit = create(:registration_unit)
            visit edit_registration_unit_path registration_unit
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}
        let(:phone) { build :phone_user, :phone => '443.859.2639'}
        let(:email) { build :email_user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            registration_unit = create :registration_unit
            visit edit_registration_unit_path registration_unit
            expect(current_path).to eq edit_registration_unit_path registration_unit
        end

    #     scenario "Success", js: true do
    #         registration_unit = create :registration_unit
    #         registration_unit_new = build :registration_unit
    #         responsible_2 = build :responsible_registration_unit

    #         state = create(:state, acronym: "MG")
    #         city = create(:city, name: "Contagem", state: state)

    #         visit edit_registration_unit_path registration_unit
    
    #         sleep 1
    #         select_from_chosen Organ.first.name, :from => "registration_unit[organ_id]"
    #         fill_in "registration_unit[name]", with: registration_unit_new.name
    #         fill_in "registration_unit[site]", with: registration_unit_new.site

    #         fill_in "registration_unit[email_users_attributes][0][email]", with: email.email
    #         fill_in "registration_unit[phone_users_attributes][0][phone]", with: phone.phone
    #         fill_in "registration_unit[zipcode]", with: "32.341-170"
    #         fill_in "registration_unit[number]", with: registration_unit_new.number
    #         sleep 4
    #         fill_in "registration_unit[complement]", with: registration_unit_new.complement
    #         select_from_chosen state.acronym, :from => "registration_unit[state_id]"
    #         select_from_chosen city.name, :from => "registration_unit[city_id]"

    #         fill_in "registration_unit[responsible_registration_units_attributes][0][name]", with: responsible_2.name
    #         fill_in "registration_unit[responsible_registration_units_attributes][0][office]", with: responsible_2.office
    #         fill_in "registration_unit[responsible_registration_units_attributes][0][whatsapp]", with: responsible_2.whatsapp
    #         fill_in "registration_unit[responsible_registration_units_attributes][0][skype]", with: responsible_2.skype
    #         fill_in "registration_unit[responsible_registration_units_attributes][0][phone_users_attributes][0][phone]", with: phone.phone
    #         fill_in "registration_unit[responsible_registration_units_attributes][0][email_users_attributes][0][email]", with: email.email
    #         sleep 1
    #         click_button "Salvar" 
    #         sleep 1

    #         expect(page).to have_content "Unidade de cadastramento editada com sucesso"
    #         expect(current_path).to eq edit_registration_unit_path registration_unit
    #         expect(RegistrationUnit.first.name).to eq registration_unit_new.name
    #         expect(RegistrationUnit.first.site).to eq registration_unit_new.site
    #         expect(RegistrationUnit.first.address).to eq "Rua Moassy"
    #         expect(RegistrationUnit.first.number).to eq registration_unit_new.number
    #         expect(RegistrationUnit.first.complement).to eq registration_unit_new.complement
    #         expect(RegistrationUnit.first.district).to eq "Novo Eldorado"
    #         expect(RegistrationUnit.first.city_id).to eq city.id
    #         expect(RegistrationUnit.first.state_id).to eq state.id

    #         expect(RegistrationUnit.first.responsible_registration_units[0].name).to eq responsible_2.name
    #         expect(RegistrationUnit.first.responsible_registration_units[0].office).to eq responsible_2.office
    #         expect(RegistrationUnit.first.responsible_registration_units[0].skype).to eq responsible_2.skype
    #         expect(RegistrationUnit.first.responsible_registration_units[0].phone_users[0].phone).to eq '(44) 3-8592'
    #         expect(RegistrationUnit.first.responsible_registration_units[0].email_users[0].email).to eq email.email
    #         expect(RegistrationUnit.first.email_users[0].email).to eq email.email
    #         expect(RegistrationUnit.first.phone_users[0].phone).to eq '(44) 3-8592'
    #     end

end
end
