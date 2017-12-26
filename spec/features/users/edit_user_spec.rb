feature "User - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            user = create(:user)
            visit edit_user_path user
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user }

        background do
            login user.email, user.password
        end

        scenario "Success" do
            user = create :user
            visit edit_user_path user
            expect(current_path).to eq edit_user_path user
        end

    #     scenario "Success", js: true do
    #         user = create(:user)
    #         user_new = build :user

    #         state = create(:state, acronym: "MG")
    #         city = create(:city, name: "Contagem", state: state)

    #         state_2 = create(:state, acronym: "AB")
    #         city_2 = create(:city, name: "Belo Horizonte", state: state_2)

    #         visit edit_user_path user
    #         select_from_chosen user_new.profile.name, :from => "user[profile_id]"

    #         fill_in "user[name]", with: user_new.name
    #         fill_in "user[rg]", with: user_new.rg
    #         fill_in "user[cpf]", with: user_new.cpf
    #         fill_in "user[email]", with: user_new.email
    #         fill_in "user[zipcode]", with: "32341170"
    #         fill_in "user[address]", with: user_new.address
    #         fill_in "user[number]", with: user_new.number
    #         fill_in "user[complement]", with: user_new.complement
    #         fill_in "user[office]", with: user_new.office
    #         fill_in "user[department]", with: user_new.department
    #         fill_in "user[skype]", with: user_new.skype
    #         fill_in "user[password]", with: user_new.password
    #         fill_in "user[birth_date]", with: '26/09/1990'
    #         sleep 1
    #         select_from_chosen state.acronym, :from => "user[state_id]"
    #         select_from_chosen city.name, :from => "user[city_id]"
    #         select_from_chosen state_2.acronym, :from => "user[office_state_id]"
    #         select_from_chosen city_2.name, :from => "user[office_city_id]"

    #         click_button "Salvar"
    #         sleep 1

    #         expect(page).to have_content "Usuário editado com sucesso"
    #         expect(current_path).to eq users_path
    #         expect(User.last.name).to eq user_new.name
    #         expect(User.last.email).to eq user_new.email
    #         expect(User.last.address).to eq "Rua Moassy"
    #         expect(User.last.number).to eq user_new.number
    #         expect(User.last.complement).to eq user_new.complement
    #         expect(User.last.district).to eq "Novo Eldorado"
    #         expect(User.last.department).to eq user_new.department
    #         expect(User.last.skype).to eq user_new.skype
    #         expect(User.last.password_to_save).to eq user_new.password
    #         expect(User.last.city_id).to eq city.id
    #         expect(User.last.state_id).to eq state.id
    #         expect(User.last.office_state_id).to eq state_2.id
    #         expect(User.last.office_city_id).to eq city_2.id

    #     end

    #     scenario "Invalid", js: true do
    #         user = create(:user)
    #         visit edit_user_path user

    #         fill_in "user[name]", with: ""
    #         fill_in "user[rg]", with: ""
    #         fill_in "user[cpf]", with: ""
    #         fill_in "user[email]", with: ""
    #         fill_in "user[zipcode]", with: ""
    #         fill_in "user[address]", with: ""
    #         fill_in "user[number]", with: ""
    #         fill_in "user[password]", with: ""
    #         fill_in "user[birth_date]", with: ""

    #         click_button "Salvar"
    #         sleep 1
    #         expect(page).to have_content "Nome completo não pode ficar em branco"
    #         expect(page).to have_content "RG não pode ficar em branco"
    #         expect(page).to have_content "CPF não pode ficar em branco"
    #         expect(page).to have_content "Email não pode ficar em branco"
    #         expect(page).to have_content "CEP não pode ficar em branco"
    #         expect(page).to have_content "Logradouro não pode ficar em branco"
    #         expect(page).to have_content "Número não pode ficar em branco"
    #         expect(page).to have_content "Data de nascimento não pode ficar em branco"
    #     end
end

end
