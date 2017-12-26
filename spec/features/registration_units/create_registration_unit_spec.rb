feature "Registration unit - Create" do

      context 'Visitor' do
            scenario "Access invalid" do
                  visit new_registration_unit_path
                  expect(current_path).to eq new_session_path
            end
      end

      context 'Admin' do
            let(:user) { create :user}
            let(:phone) { build :phone_user, :phone => '443.859.2639'}
            let(:email) { build :email_user}
            let(:responsible) { build :responsible_registration_unit}

            background do
                  login user.email, user.password
            end
            
            scenario "Success" do
                  visit new_registration_unit_path
                  expect(current_path).to eq new_registration_unit_path
            end

      #       scenario "Success", js: true do
      #             registration_unit = (build :registration_unit)

      #             state = create(:state, acronym: "MG")
      #             city = create(:city, name: "Contagem", state: state)

      #             visit new_registration_unit_path
      #             sleep 1
      #             select_from_chosen Organ.first.name, :from => "registration_unit[organ_id]"
      #             fill_in "registration_unit[name]", with: registration_unit.name
      #             fill_in "registration_unit[site]", with: registration_unit.site

      #             fill_in "registration_unit[email_users_attributes][0][email]", with: email.email
      #             fill_in "registration_unit[phone_users_attributes][0][phone]", with: phone.phone
      #             fill_in "registration_unit[zipcode]", with: "32.341-170"
      #             fill_in "registration_unit[number]", with: registration_unit.number
      #             sleep 4
      #             fill_in "registration_unit[complement]", with: registration_unit.complement
      #             select_from_chosen state.acronym, :from => "registration_unit[state_id]"
      #             select_from_chosen city.name, :from => "registration_unit[city_id]"
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][name]", with: responsible.name
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][office]", with: responsible.office
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][whatsapp]", with: responsible.whatsapp
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][skype]", with: responsible.skype
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][phone_users_attributes][0][phone]", with: phone.phone
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][email_users_attributes][0][email]", with: email.email
      #             sleep 1
      #             click_button "Salvar" 
      #             sleep 1

      #             expect(page).to have_content "Unidade de cadastramento cadastrada com sucesso"
      #             expect(current_path).to eq registration_units_path
      #             expect(RegistrationUnit.last.name).to eq registration_unit.name
      #             expect(RegistrationUnit.last.site).to eq registration_unit.site
      #             expect(RegistrationUnit.last.address).to eq "Rua Moassy"
      #             expect(RegistrationUnit.last.number).to eq registration_unit.number
      #             expect(RegistrationUnit.last.complement).to eq registration_unit.complement
      #             expect(RegistrationUnit.last.district).to eq "Novo Eldorado"
      #             expect(RegistrationUnit.last.city_id).to eq city.id
      #             expect(RegistrationUnit.last.state_id).to eq state.id

      #             expect(RegistrationUnit.last.responsible_registration_units[0].name).to eq responsible.name
      #             expect(RegistrationUnit.last.responsible_registration_units[0].office).to eq responsible.office
      #             expect(RegistrationUnit.last.responsible_registration_units[0].skype).to eq responsible.skype
      #             expect(RegistrationUnit.last.responsible_registration_units[0].phone_users[0].phone).to eq '(44) 3-8592'
      #             expect(RegistrationUnit.last.responsible_registration_units[0].email_users[0].email).to eq email.email
      #             expect(RegistrationUnit.last.email_users[0].email).to eq email.email
      #             expect(RegistrationUnit.last.phone_users[0].phone).to eq '(44) 3-8592'
      #       end

      #       scenario "Success - adding unit and responsible", js: true do
      #             registration_unit = (build :registration_unit)
      #             registration_unit_2 = (build :registration_unit)
      #             responsible_2 = (build :responsible_registration_unit)

      #             state = create(:state, acronym: "MG")
      #             city = create(:city, name: "Contagem", state: state)

      #             visit new_registration_unit_path
      #             sleep 1
      #             select_from_chosen Organ.first.name, :from => "registration_unit[organ_id]"
      #             fill_in "registration_unit[name]", with: registration_unit.name
      #             fill_in "registration_unit[site]", with: registration_unit.site

      #             fill_in "registration_unit[email_users_attributes][0][email]", with: email.email
      #             fill_in "registration_unit[phone_users_attributes][0][phone]", with: phone.phone
      #             fill_in "registration_unit[zipcode]", with: "32.341-170"
      #             fill_in "registration_unit[number]", with: registration_unit.number
      #             sleep 4
      #             fill_in "registration_unit[complement]", with: registration_unit.complement
      #             fill_in "registration_unit[responsible_registration_units_attributes][0][name]", with: responsible.name
      #             sleep 1

      #             click_button "Adicionar unidade" 

      #             select_from_chosen Organ.last.name, :from => "registration_unit[registration_units_attributes][0][organ_id]"
      #             fill_in "registration_unit[registration_units_attributes][0][name]", with: registration_unit_2.name
      #             fill_in "registration_unit[registration_units_attributes][0][site]", with: registration_unit_2.site

      #             fill_in "registration_unit[registration_units_attributes][0][email_users_attributes][0][email]", with: email.email
      #             fill_in "registration_unit[registration_units_attributes][0][phone_users_attributes][0][phone]", with: phone.phone
      #             fill_in "registration_unit[registration_units_attributes][0][zipcode]", with: "32.341-170"
      #             fill_in "registration_unit[registration_units_attributes][0][number]", with: registration_unit_2.number
      #             sleep 4
      #             fill_in "registration_unit[registration_units_attributes][0][complement]", with: registration_unit_2.complement

      #             click_button "Adicionar responsável"

      #             fill_in "registration_unit[responsible_registration_units_attributes][1][name]", with: responsible_2.name
      #             fill_in "registration_unit[responsible_registration_units_attributes][1][office]", with: responsible_2.office
      #             fill_in "registration_unit[responsible_registration_units_attributes][1][whatsapp]", with: responsible_2.whatsapp
      #             fill_in "registration_unit[responsible_registration_units_attributes][1][skype]", with: responsible_2.skype
      #             fill_in "registration_unit[responsible_registration_units_attributes][1][phone_users_attributes][0][phone]", with: phone.phone
      #             fill_in "registration_unit[responsible_registration_units_attributes][1][email_users_attributes][0][email]", with: email.email

      #             click_button "Salvar" 
      #             sleep 1

      #             expect(page).to have_content "Unidade de cadastramento cadastrada com sucesso"
      #             registration_unit_last = RegistrationUnit.where(:registration_unit_id => nil).last

      #             expect(current_path).to eq registration_units_path
      #             expect(registration_unit_last.name).to eq registration_unit.name
      #             expect(registration_unit_last.site).to eq registration_unit.site
      #             expect(registration_unit_last.address).to eq "Rua Moassy"
      #             expect(registration_unit_last.number).to eq registration_unit.number
      #             expect(registration_unit_last.complement).to eq registration_unit.complement
      #             expect(registration_unit_last.district).to eq "Novo Eldorado"
      #             expect(registration_unit_last.city_id).to eq city.id
      #             expect(registration_unit_last.state_id).to eq state.id
      #             expect(registration_unit_last.responsible_registration_units[0].name).to eq responsible.name

      #             expect(registration_unit_last.responsible_registration_units[1].name).to eq responsible_2.name
      #             expect(registration_unit_last.responsible_registration_units[1].office).to eq responsible_2.office
      #             expect(registration_unit_last.responsible_registration_units[1].skype).to eq responsible_2.skype
      #             expect(registration_unit_last.responsible_registration_units[1].phone_users[0].phone).to eq '(44) 3-8592'
      #             expect(registration_unit_last.responsible_registration_units[1].email_users[0].email).to eq email.email

      #             expect(registration_unit_last.email_users[0].email).to eq email.email
      #             expect(registration_unit_last.phone_users[0].phone).to eq '(44) 3-8592'

      #             expect(registration_unit_last.registration_units[0].name).to eq registration_unit_2.name
      #             expect(registration_unit_last.registration_units[0].site).to eq registration_unit_2.site
      #             expect(registration_unit_last.registration_units[0].address).to eq "Rua Moassy"
      #             expect(registration_unit_last.registration_units[0].number).to eq registration_unit_2.number
      #             expect(registration_unit_last.registration_units[0].complement).to eq registration_unit_2.complement
      #             expect(registration_unit_last.registration_units[0].district).to eq "Novo Eldorado"
      #             expect(registration_unit_last.registration_units[0].city_id).to eq city.id
      #             expect(registration_unit_last.registration_units[0].state_id).to eq state.id
      #             expect(registration_unit_last.registration_units[0].email_users[0].email).to eq email.email
      #             expect(registration_unit_last.registration_units[0].phone_users[0].phone).to eq '(44) 3-8592'
      #       end

      #       scenario "invalid fields", js: true do
      #             visit new_registration_unit_path
      #             click_button "Salvar"
      #             sleep 1
      #             expect(page).to have_content "Orgão não pode ficar em branco"
      #             expect(page).to have_content "Nome não pode ficar em branco"
      #             expect(page).to have_content "CEP não pode ficar em branco"
      #             expect(page).to have_content "Logradouro não pode ficar em branco"
      #             expect(page).to have_content "Bairro não pode ficar em branco"
      #             expect(page).to have_content "Número não pode ficar em branco"
      #             expect(page).to have_content "Estado não pode ficar em branco"
      #             expect(page).to have_content "Cidade não pode ficar em branco"
      #             expect(page).to have_content "Nome não pode ficar em branco"
      #       end
end
end
