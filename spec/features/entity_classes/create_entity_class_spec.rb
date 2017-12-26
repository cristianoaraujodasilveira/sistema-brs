feature "Entity Class - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_entity_class_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success", js: true do
            entity_class = build :entity_class
            entity_class_responsible = build :entity_class_responsible

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit new_entity_class_path

            fill_in "entity_class[name]", with: entity_class.name
            fill_in "entity_class[description]", with: entity_class.description
            fill_in "entity_class[zipcode]", with: "32341170"
            fill_in "entity_class[number]", with: entity_class.number
            sleep 5
            fill_in "entity_class[complement]", with: entity_class.complement

            fill_in "entity_class[entity_class_responsibles_attributes][0][name]", with: entity_class_responsible.name
            fill_in "entity_class[entity_class_responsibles_attributes][0][office]", with: entity_class_responsible.office
            fill_in "entity_class[entity_class_responsibles_attributes][0][department]", with: entity_class_responsible.department
            fill_in "entity_class[entity_class_responsibles_attributes][0][whatsapp]", with: "(24) 21421-4141"
            fill_in "entity_class[entity_class_responsibles_attributes][0][skype]", with: entity_class_responsible.skype

            fill_in "entity_class[entity_class_responsibles_attributes][0][email_users_attributes][0][email]", with: "email@email.com"
            
            sleep 1
            select_from_chosen state.acronym, :from => "entity_class[state_id]"
            select_from_chosen city.name, :from => "entity_class[city_id]"

            click_button "Salvar" 
            sleep 1 

            expect(page).to have_content "Entidade de classe cadastrada com sucesso"
            expect(current_path).to eq entity_classes_path
            expect(EntityClass.last.name).to eq entity_class.name
            expect(EntityClass.last.description).to eq entity_class.description
            expect(EntityClass.last.address).to eq "Rua Moassy"
            expect(EntityClass.last.number).to eq entity_class.number
            expect(EntityClass.last.complement).to eq entity_class.complement
            expect(EntityClass.last.district).to eq "Novo Eldorado"
            expect(EntityClass.last.city_id).to eq city.id
            expect(EntityClass.last.state_id).to eq state.id
            
            expect(EntityClass.last.entity_class_responsibles[0].name).to eq entity_class_responsible.name
            expect(EntityClass.last.entity_class_responsibles[0].office).to eq entity_class_responsible.office
            expect(EntityClass.last.entity_class_responsibles[0].department).to eq entity_class_responsible.department
            expect(EntityClass.last.entity_class_responsibles[0].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.last.entity_class_responsibles[0].skype).to eq entity_class_responsible.skype

            expect(EntityClass.last.entity_class_responsibles[0].email_users[0].email).to eq "email@email.com"
        end

        scenario "Success adding responsible", js: true do
            entity_class = build :entity_class
            entity_class_responsible = build :entity_class_responsible
            entity_class_responsible_2 = build :entity_class_responsible

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit new_entity_class_path

            click_button "Adicionar responsável" 


            fill_in "entity_class[name]", with: entity_class.name
            fill_in "entity_class[description]", with: entity_class.description
            fill_in "entity_class[zipcode]", with: "32341170"
            fill_in "entity_class[number]", with: entity_class.number
            sleep 5
            fill_in "entity_class[complement]", with: entity_class.complement
            
            select_from_chosen state.acronym, :from => "entity_class[state_id]"
            select_from_chosen city.name, :from => "entity_class[city_id]"

            fill_in "entity_class[entity_class_responsibles_attributes][0][name]", with: entity_class_responsible.name
            fill_in "entity_class[entity_class_responsibles_attributes][0][office]", with: entity_class_responsible.office
            fill_in "entity_class[entity_class_responsibles_attributes][0][department]", with: entity_class_responsible.department
            fill_in "entity_class[entity_class_responsibles_attributes][0][whatsapp]", with: "(24) 21421-4141"
            fill_in "entity_class[entity_class_responsibles_attributes][0][skype]", with: entity_class_responsible.skype

            fill_in "entity_class[entity_class_responsibles_attributes][0][email_users_attributes][0][email]", with: "email@email.com"

            fill_in "entity_class[entity_class_responsibles_attributes][1][name]", with: entity_class_responsible_2.name
            fill_in "entity_class[entity_class_responsibles_attributes][1][office]", with: entity_class_responsible_2.office
            fill_in "entity_class[entity_class_responsibles_attributes][1][department]", with: entity_class_responsible_2.department
            fill_in "entity_class[entity_class_responsibles_attributes][1][whatsapp]", with: "(24) 21421-4141"
            fill_in "entity_class[entity_class_responsibles_attributes][1][skype]", with: entity_class_responsible_2.skype

            fill_in "entity_class[entity_class_responsibles_attributes][1][email_users_attributes][0][email]", with: "email@email.com"
            
            sleep 1

            click_button "Salvar" 
            sleep 1 

            expect(page).to have_content "Entidade de classe cadastrada com sucesso"
            expect(current_path).to eq entity_classes_path
            expect(EntityClass.last.name).to eq entity_class.name
            expect(EntityClass.last.description).to eq entity_class.description
            expect(EntityClass.last.address).to eq "Rua Moassy"
            expect(EntityClass.last.number).to eq entity_class.number
            expect(EntityClass.last.complement).to eq entity_class.complement
            expect(EntityClass.last.district).to eq "Novo Eldorado"
            expect(EntityClass.last.city_id).to eq city.id
            expect(EntityClass.last.state_id).to eq state.id
            
            expect(EntityClass.last.entity_class_responsibles[0].name).to eq entity_class_responsible.name
            expect(EntityClass.last.entity_class_responsibles[0].office).to eq entity_class_responsible.office
            expect(EntityClass.last.entity_class_responsibles[0].department).to eq entity_class_responsible.department
            expect(EntityClass.last.entity_class_responsibles[0].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.last.entity_class_responsibles[0].skype).to eq entity_class_responsible.skype  

            expect(EntityClass.last.entity_class_responsibles[1].name).to eq entity_class_responsible_2.name
            expect(EntityClass.last.entity_class_responsibles[1].office).to eq entity_class_responsible_2.office
            expect(EntityClass.last.entity_class_responsibles[1].department).to eq entity_class_responsible_2.department
            expect(EntityClass.last.entity_class_responsibles[1].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.last.entity_class_responsibles[1].skype).to eq entity_class_responsible_2.skype

            expect(EntityClass.last.entity_class_responsibles[1].email_users[0].email).to eq "email@email.com"
        end

        scenario "invalid fields", js: true do
            visit new_entity_class_path
            click_button "Salvar"
            sleep 1
            expect(page).to have_content "Nome não pode ficar em branco"
            expect(page).to have_content "Nome do responsável não pode ficar em branco"
        end
    end
end
