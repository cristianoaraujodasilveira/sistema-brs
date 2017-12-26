feature "User - Create" do

    context 'Visitor' do
        # Cenário para validar se usuários não autenticados são bloqueados de acessar a página
        scenario "Access invalid", js: true do
            visit new_user_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:admin_user) { create :user}

        background do
            login admin_user.email, admin_user.password
        end

        scenario "Success" do
            visit new_user_path
            expect(current_path).to eq new_user_path
        end

    #     # Cenário de sucesso - Verifica se todos os dados inseridos estão sendo salvos corretamente
    #     scenario "Success", js: true do
    #         # Criação do ambiente para teste
    #         user = build :user
    #         state = create(:state, acronym: "MG")
    #         city = create(:city, name: "Contagem", state: state)
    #         state_2 = create(:state, acronym: "AB")
    #         city_2 = create(:city, name: "Belo Horizonte", state: state)
    #         visit new_user_path

    #         # Preenchimento automático dos campos do formulário
    #         select_from_chosen Profile.first.name, :from => "user[profile_id]"
    #         fill_in "user[name]", with: user.name
    #         fill_in "user[rg]", with: user.rg
    #         fill_in "user[cpf]", with: user.cpf
    #         fill_in "user[email]", with: user.email
    #         fill_in "user[zipcode]", with: "30110915"
    #         fill_in "user[number]", with: user.number
    #         sleep 4
    #         fill_in "user[complement]", with: user.complement
    #         fill_in "user[office]", with: user.office
    #         fill_in "user[department]", with: user.department
    #         fill_in "user[skype]", with: user.skype
    #         fill_in "user[password]", with: user.password
    #         fill_in "user[birth_date]", with: '26/09/1990'
    #         fill_in "user_phone_users_attributes_0_phone", with: '(31) 99999-9999'
    #         fill_in "user_email_users_attributes_0_email", with: 'teste@teste.com.br'
    #         sleep 1
    #         select_from_chosen state.acronym, :from => "user[office_state_id]"
    #         select_from_chosen city_2.name, :from => "user[office_city_id]"

    #         # Clica no botão salvar
    #         click_button "Salvar" 
    #         sleep 1 

    #         # Resultados esperados
    #         expect(page).to have_content "Usuário cadastrado com sucesso"
    #         expect(current_path).to eq users_path
    #         expect(User.last.name).to eq user.name
    #         expect(User.last.email).to eq user.email
    #         expect(User.last.address).to eq "Avenida do Contorno, 2905"
    #         expect(User.last.number).to eq user.number
    #         expect(User.last.complement).to eq user.complement
    #         expect(User.last.district).to eq "Santa Efigênia"
    #         expect(User.last.department).to eq user.department
    #         expect(User.last.skype).to eq user.skype
    #         expect(User.last.password_to_save).to eq user.password
    #         expect(User.last.city_id).to eq city_2.id
    #         expect(User.last.state_id).to eq state.id
    #         expect(User.last.office_state_id).to eq state.id
    #         expect(User.last.office_city_id).to eq city_2.id
    #         expect(User.last.phone_users[0].phone).to eq '(31) 99999-9999'
    #         expect(User.last.email_users[0].email).to eq 'teste@teste.com.br'
    #         expect(open_last_email).to be_delivered_to admin_user.email
    #     end

    #     # Cenário campos inválidos - Verifica se o sistema está bloqueando salvar registros sem preencher todos os campos obrigatórios
    #     scenario "invalid fields", js: true do
    #         # Visita a tela para cadastro de novo registro
    #         visit new_user_path

    #         # Clica no botão salvar sem preencher nenhum campo
    #         click_button "Salvar"
    #         sleep 1

    #         # Resultados esperados
    #         expect(page).to have_content "Tipo não pode ficar em branco"
    #         expect(page).to have_content "Nome completo não pode ficar em branco"
    #         expect(page).to have_content "Email não pode ficar em branco"
    #         expect(page).to have_content "Senha não pode ficar em branco"
    #         expect(page).to have_content "CEP não pode ficar em branco"
    #         expect(page).to have_content "Logradouro não pode ficar em branco"
    #         expect(page).to have_content "Bairro não pode ficar em branco"
    #         expect(page).to have_content "Número não pode ficar em branco"
    #         expect(page).to have_content "Estado não pode ficar em branco"
    #         expect(page).to have_content "Cidade não pode ficar em branco"
    #         expect(page).to have_content "RG não pode ficar em branco"
    #         expect(page).to have_content "CPF não pode ficar em branco"
    #         expect(page).to have_content "Data de nascimento não pode ficar em branco"
    #     end
end
end
