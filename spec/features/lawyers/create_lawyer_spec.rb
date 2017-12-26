feature "Lawyer - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_lawyer_path
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
            lawyer = build :lawyer

            visit new_lawyer_path

            select_from_chosen lawyer.lawyer_type.name, :from => "lawyer[lawyer_type_id]"
            fill_in "lawyer[name]", with: lawyer.name
            fill_in "lawyer[created_date]", with: '26/09/1990 16:03'
            fill_in "lawyer[office]", with: lawyer.office

            fill_in "lawyer[cnpj]", with: lawyer.cnpj
            fill_in "lawyer[cpf]", with: lawyer.cpf
            fill_in "lawyer[oab]", with: lawyer.oab

            select_from_chosen State.where(:acronym => "MG").first.acronym, :from => "lawyer[state_id]"
            select_from_chosen City.where(:name => "Contagem").first.name, :from => "lawyer[city_id]"

            fill_in "lawyer[emails_attributes][0][email]", with: 'email@email.com'
            select_from_chosen lawyer.honorary_form.name, :from => "lawyer[honorary_form_id]"
            fill_in "lawyer[honorary_value]", with: lawyer.honorary_value

            page.execute_script("$('#lawyer_addresses_attributes_0_zipcode').val('32.341-170')")
            fill_in "lawyer[addresses_attributes][0][number]", with: '240'

            page.execute_script("$('#lawyer_addresses_attributes_1_zipcode').val('32.341-170')")
            fill_in "lawyer[addresses_attributes][1][number]", with: '240'

            select_from_chosen State.where(:acronym => "MG").first.acronym, :from => "lawyer[addresses_attributes][0][state_id]"
            select_from_chosen City.where(:name => "Contagem").first.name, :from => "lawyer[addresses_attributes][0][city_id]"

            select_from_chosen State.where(:acronym => "MG").first.acronym, :from => "lawyer[addresses_attributes][1][state_id]"
            select_from_chosen City.where(:name => "Contagem").first.name, :from => "lawyer[addresses_attributes][1][city_id]"

            fill_in "lawyer[addresses_attributes][0][address]", with: 'Rua Moassy'
            fill_in "lawyer[addresses_attributes][0][number]", with: '240'
            fill_in "lawyer[addresses_attributes][0][district]", with: 'Novo Eldorado'

            fill_in "lawyer[addresses_attributes][1][address]", with: 'Rua Moassy'
            fill_in "lawyer[addresses_attributes][1][number]", with: '240'
            fill_in "lawyer[addresses_attributes][1][district]", with: 'Novo Eldorado'

            click_button "Salvar" 
            sleep 1
            expect(page).to have_content "Advogado cadastrado com sucesso"
            expect(current_path).to eq edit_lawyer_path Lawyer.last.id
            lawyer_last = Lawyer.last

            expect(lawyer_last.lawyer_type_id).to eq lawyer.lawyer_type.id
            expect(lawyer_last.name).to eq lawyer.name
            expect(lawyer_last.office).to eq lawyer.office
            expect(lawyer_last.cnpj).to eq lawyer.cnpj
            expect(lawyer_last.cpf).to eq lawyer.cpf
            expect(lawyer_last.honorary_form_id).to eq lawyer.honorary_form.id

            expect(lawyer_last.addresses[0].address).to eq 'Rua Moassy'
            expect(lawyer_last.addresses[1].address).to eq 'Rua Moassy'
            expect(lawyer_last.emails[0].email).to eq 'email@email.com'
        end

        scenario "invalid fields", js:true do
            visit new_lawyer_path
            click_button "Salvar"
            sleep 1

            expect(page).to have_content "CEP não pode ficar em branco"
            expect(page).to have_content "Logradouro não pode ficar em branco"
            expect(page).to have_content "Bairro não pode ficar em branco"
            expect(page).to have_content "Número não pode ficar em branco"
            expect(page).to have_content "Estado não pode ficar em branco"
            expect(page).to have_content "Cidade não pode ficar em branco"
            expect(page).to have_content "Tipo não pode ficar em branco"
            expect(page).to have_content "Nome completo não pode ficar em branco"
            expect(page).to have_content "CPF não pode ficar em branco"
            expect(page).to have_content "OAB não pode ficar em branco"
            expect(page).to have_content "Valor do honorário não pode ficar em branco"
            expect(page).to have_content "Forma de honorário não pode ficar em branco"
        end
    end
end
