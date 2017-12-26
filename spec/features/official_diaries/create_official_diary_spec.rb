feature "Official Diary - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_official_diary_path
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
            official_diary = build :official_diary
            responsible = build :responsible

            visit new_official_diary_path
            fill_in "official_diary[name]", with: official_diary.name
            fill_in "official_diary[social_name]", with: official_diary.social_name
            fill_in "official_diary[cnpj]", with: official_diary.cnpj
            fill_in "official_diary[email_brs]", with: official_diary.email_brs
            fill_in "official_diary[site]", with: official_diary.site

            select_from_chosen official_diary.sphere.name, :from => "official_diary[sphere_id]"

            fill_in "official_diary[address_attributes][zipcode]", with: '32.341-170'
            fill_in "official_diary[address_attributes][number]", with: '240'
            sleep 5

            fill_in "official_diary[observations_attributes][1][observation]", with: 'Observation'

            fill_in "official_diary[responsibles_attributes][0][name]", with: responsible.name
            fill_in "official_diary[responsibles_attributes][0][office]", with: responsible.office
            fill_in "official_diary[responsibles_attributes][0][department]", with: responsible.department
            fill_in "official_diary[responsibles_attributes][0][emails_attributes][0][email]", with: 'email'
            fill_in "official_diary[responsibles_attributes][0][skypes_attributes][0][skype]", with: 'skype'

            click_button "Salvar" 
            sleep 1
            expect(page).to have_content "Diário Oficial cadastrado com sucesso"

            official_diary_last = OfficialDiary.last

            expect(current_path).to eq edit_official_diary_path official_diary_last.id

            expect(official_diary_last.user_id).to eq user.id
            expect(official_diary_last.name).to eq official_diary.name
            expect(official_diary_last.social_name).to eq official_diary.social_name
            expect(official_diary_last.cnpj).to eq official_diary.cnpj
            expect(official_diary_last.email_brs).to eq official_diary.email_brs
            expect(official_diary_last.site).to eq official_diary.site

            expect(official_diary_last.sphere_id).to eq official_diary.sphere_id
            expect(official_diary_last.address.address).to eq 'Rua Moassy'

            expect(official_diary_last.observations[0].observation).to eq 'Observation'

            expect(official_diary_last.responsibles[0].name).to eq responsible.name
            expect(official_diary_last.responsibles[0].office).to eq responsible.office
            expect(official_diary_last.responsibles[0].department).to eq responsible.department
            expect(official_diary_last.responsibles[0].emails[0].email).to eq 'email'
            expect(official_diary_last.responsibles[0].skypes[0].skype).to eq 'skype'

        end

        scenario "invalid fields", js:true do
            visit new_official_diary_path
            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Nome do Diário não pode ficar em branco"
            expect(page).to have_content "Razão Social não pode ficar em branco"
            expect(page).to have_content "CNPJ não pode ficar em branco"
        end
    end
end
