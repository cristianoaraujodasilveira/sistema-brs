feature "Entity Class - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            entity_class = (create :entity_class)
            visit edit_entity_class_path entity_class
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success", js: true do
            entity_class = create :entity_class
            entity_class_new = build :entity_class

            entity_class_responsible = build :entity_class_responsible

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            state_2 = create(:state, acronym: "BH")
            city_2 = create(:city, name: "Teste", state: state_2)

            visit edit_entity_class_path entity_class

            fill_in "entity_class[name]", with: entity_class_new.name
            fill_in "entity_class[description]", with: entity_class_new.description
            fill_in "entity_class[zipcode]", with: "32341170"
            fill_in "entity_class[number]", with: entity_class_new.number
            sleep 5
            fill_in "entity_class[complement]", with: entity_class_new.complement

            sleep 1
            select_from_chosen state_2.acronym, :from => "entity_class[state_id]"
            select_from_chosen city_2.name, :from => "entity_class[city_id]"

            fill_in "entity_class[entity_class_responsibles_attributes][0][name]", with: entity_class_responsible.name
            fill_in "entity_class[entity_class_responsibles_attributes][0][office]", with: entity_class_responsible.office
            fill_in "entity_class[entity_class_responsibles_attributes][0][department]", with: entity_class_responsible.department
            fill_in "entity_class[entity_class_responsibles_attributes][0][whatsapp]", with: "(24) 21421-4141"
            fill_in "entity_class[entity_class_responsibles_attributes][0][skype]", with: entity_class_responsible.skype

            fill_in "entity_class[entity_class_responsibles_attributes][0][email_users_attributes][0][email]", with: "email@email.com"

            click_button "Salvar" 
            sleep 1 

            expect(page).to have_content "Entidade de classe editada com sucesso"
            expect(current_path).to eq edit_entity_class_path entity_class
            expect(EntityClass.first.name).to eq entity_class_new.name
            expect(EntityClass.first.description).to eq entity_class_new.description
            expect(EntityClass.first.address).to eq "Rua Moassy"
            expect(EntityClass.first.number).to eq entity_class_new.number
            expect(EntityClass.first.complement).to eq entity_class_new.complement
            expect(EntityClass.first.district).to eq "Novo Eldorado"
            expect(EntityClass.first.city_id).to eq city_2.id
            expect(EntityClass.first.state_id).to eq state_2.id
            
            expect(EntityClass.first.entity_class_responsibles[0].name).to eq entity_class_responsible.name
            expect(EntityClass.first.entity_class_responsibles[0].office).to eq entity_class_responsible.office
            expect(EntityClass.first.entity_class_responsibles[0].department).to eq entity_class_responsible.department
            expect(EntityClass.first.entity_class_responsibles[0].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.first.entity_class_responsibles[0].skype).to eq entity_class_responsible.skype

            expect(EntityClass.first.entity_class_responsibles[0].email_users[0].email).to eq "email@email.com"
        end

        scenario "Success adding responsible", js: true do
            entity_class = create :entity_class

            entity_class_responsible = build :entity_class_responsible
            entity_class_responsible_2 = build :entity_class_responsible

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit edit_entity_class_path entity_class

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

            expect(page).to have_content "Entidade de classe editada com sucesso"
            expect(current_path).to eq edit_entity_class_path entity_class
            expect(EntityClass.first.name).to eq entity_class.name
            expect(EntityClass.first.description).to eq entity_class.description
            expect(EntityClass.first.address).to eq "Rua Moassy"
            expect(EntityClass.first.number).to eq entity_class.number
            expect(EntityClass.first.complement).to eq entity_class.complement
            expect(EntityClass.first.district).to eq "Novo Eldorado"
            expect(EntityClass.first.city_id).to eq city.id
            expect(EntityClass.first.state_id).to eq state.id
            
            expect(EntityClass.first.entity_class_responsibles[0].name).to eq entity_class_responsible.name
            expect(EntityClass.first.entity_class_responsibles[0].office).to eq entity_class_responsible.office
            expect(EntityClass.first.entity_class_responsibles[0].department).to eq entity_class_responsible.department
            expect(EntityClass.first.entity_class_responsibles[0].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.first.entity_class_responsibles[0].skype).to eq entity_class_responsible.skype  

            expect(EntityClass.first.entity_class_responsibles[1].name).to eq entity_class_responsible_2.name
            expect(EntityClass.first.entity_class_responsibles[1].office).to eq entity_class_responsible_2.office
            expect(EntityClass.first.entity_class_responsibles[1].department).to eq entity_class_responsible_2.department
            expect(EntityClass.first.entity_class_responsibles[1].whatsapp).to eq "(24) 21421-4141"
            expect(EntityClass.first.entity_class_responsibles[1].skype).to eq entity_class_responsible_2.skype

            expect(EntityClass.first.entity_class_responsibles[1].email_users[0].email).to eq "email@email.com"
        end

    end
end
