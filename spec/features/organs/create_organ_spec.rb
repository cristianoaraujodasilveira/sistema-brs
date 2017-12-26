feature "Organ - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_organ_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            visit new_organ_path
            expect(current_path).to eq new_organ_path
        end

        # scenario "Success", js: true do
        #     organ = (build :organ, :with_sectors)

        #     state = create(:state, acronym: "MG")
        #     city = create(:city, name: "Contagem", state: state)
        #     create(:electronic_portal)

        #     visit new_organ_path
        #     sleep 1
        #     select_from_chosen Sphere.first.name, :from => "organ[sphere_id]"
        #     fill_in "organ[name]", with: organ.name
        #     fill_in "organ[cnpj]", with: organ.cnpj
        #     fill_in "organ[site]", with: organ.site
        #     fill_in "organ[email]", with: organ.email
        #     fill_in "organ[zipcode]", with: "32341170"
        #     fill_in "organ[number]", with: organ.number
        #     sleep 4
        #     fill_in "organ[complement]", with: organ.complement
        #     fill_in "organ[identification_number]", with: organ.identification_number    
        #     fill_in "organ[observation]", with: organ.observation   

        #     fill_in "organ[sectors_attributes][0][name]", with: organ.sectors.last.name    
        #     fill_in "organ[sectors_attributes][0][responsible_name]", with: organ.sectors.last.responsible_name    
        #     sleep 1
        #     click_button "Salvar" 
        #     sleep 1

        #     expect(page).to have_content "Orgão cadastrado com sucesso"
        #     expect(current_path).to eq organs_path
        #     expect(Organ.last.name).to eq organ.name
        #     expect(Organ.last.site).to eq organ.site
        #     expect(Organ.last.email).to eq organ.email
        #     expect(Organ.last.address).to eq "Rua Moassy"
        #     expect(Organ.last.number).to eq organ.number
        #     expect(Organ.last.complement).to eq organ.complement
        #     expect(Organ.last.district).to eq "Novo Eldorado"
        #     expect(Organ.last.city_id).to eq city.id
        #     expect(Organ.last.state_id).to eq state.id
        #     expect(Organ.last.sectors.last.name).to eq organ.sectors.last.name
        #     expect(Organ.last.sectors.last.responsible_name).to eq organ.sectors.last.responsible_name
        # end

        # scenario "Success - adding branch and sector", js: true do
        #     organ = (build :organ, :with_sectors)
        #     organ_branch = (build :organ, :with_branchs)
        #     organ_sector = (build :organ, :with_sectors)

        #     state = create(:state, acronym: "MG")
        #     city = create(:city, name: "Contagem", state: state)

        #     visit new_organ_path
        #     sleep 1
        #     select_from_chosen Sphere.first.name, :from => "organ[sphere_id]"
        #     fill_in "organ[name]", with: organ.name
        #     fill_in "organ[cnpj]", with: organ.cnpj
        #     fill_in "organ[site]", with: organ.site
        #     fill_in "organ[electronic_portal]", with: organ.electronic_portal
        #     fill_in "organ[email]", with: organ.email
        #     fill_in "organ[phone]", with: organ.phone
        #     fill_in "organ[zipcode]", with: "32341170"
        #     fill_in "organ[number]", with: organ.number
        #     sleep 2
        #     fill_in "organ[complement]", with: organ.complement
        #     fill_in "organ[identification_number]", with: organ.identification_number    
        #     fill_in "organ[observation]", with: organ.observation   

        #     fill_in "organ[sectors_attributes][0][name]", with: organ.sectors.last.name    
        #     fill_in "organ[sectors_attributes][0][responsible_name]", with: organ.sectors.last.responsible_name    
        #     sleep 1

        #     # Adicionando filial
        #     click_button "Adicionar filial" 
        #     sleep 1
        #     select_from_chosen Sphere.last.name, :from => "organ[organs_attributes][0][sphere_id]"
        #     fill_in "organ[organs_attributes][0][name]", with: organ_branch.name
        #     fill_in "organ[organs_attributes][0][cnpj]", with: organ_branch.cnpj
        #     fill_in "organ[organs_attributes][0][site]", with: organ_branch.site
        #     fill_in "organ[organs_attributes][0][electronic_portal]", with: organ_branch.electronic_portal
        #     fill_in "organ[organs_attributes][0][email]", with: organ_branch.email
        #     fill_in "organ[organs_attributes][0][phone]", with: organ_branch.phone
        #     fill_in "organ[organs_attributes][0][zipcode]", with: "32341170"
        #     fill_in "organ[organs_attributes][0][number]", with: organ_branch.number
        #     sleep 4
        #     fill_in "organ[organs_attributes][0][complement]", with: organ_branch.complement
        #     fill_in "organ[organs_attributes][0][identification_number]", with: organ_branch.identification_number    
        #     fill_in "organ[organs_attributes][0][observation]", with: organ_branch.observation   

        #     # Adicionando setor
        #     click_button "Adicionar setor" 
        #     sleep 1
        #     fill_in "organ[sectors_attributes][1][name]", with: organ_sector.sectors.last.name    
        #     fill_in "organ[sectors_attributes][1][responsible_name]", with: organ_sector.sectors.last.responsible_name 


        #     click_button "Salvar" 
        #     sleep 1

        #     expect(page).to have_content "Orgão cadastrado com sucesso"
        #     expect(current_path).to eq organs_path
        #     expect(Organ.first.sphere_id).to eq Sphere.first.id
        #     expect(Organ.first.name).to eq organ.name
        #     expect(Organ.first.site).to eq organ.site
        #     expect(Organ.first.electronic_portal).to eq organ.electronic_portal
        #     expect(Organ.first.email).to eq organ.email
        #     expect(Organ.first.address).to eq "Rua Moassy"
        #     expect(Organ.first.number).to eq organ.number
        #     expect(Organ.first.complement).to eq organ.complement
        #     expect(Organ.first.district).to eq "Novo Eldorado"
        #     expect(Organ.first.city_id).to eq city.id
        #     expect(Organ.first.state_id).to eq state.id
        #     expect(Organ.first.sectors.first.name).to eq organ.sectors.last.name
        #     expect(Organ.first.sectors.first.responsible_name).to eq organ.sectors.last.responsible_name
        #     expect(Organ.first.sectors.last.name).to eq organ_sector.sectors.last.name
        #     expect(Organ.first.sectors.last.responsible_name).to eq organ_sector.sectors.last.responsible_name

        #     expect(Organ.first.organs.last.sphere_id).to eq Sphere.last.id
        #     expect(Organ.first.organs.last.name).to eq organ_branch.name
        #     expect(Organ.first.organs.last.cnpj).to eq organ_branch.cnpj
        #     expect(Organ.first.organs.last.site).to eq organ_branch.site
        #     expect(Organ.first.organs.last.electronic_portal).to eq organ_branch.electronic_portal
        #     expect(Organ.first.organs.last.email).to eq organ_branch.email
        #     expect(Organ.first.organs.last.address).to eq "Rua Moassy"
        #     expect(Organ.first.organs.last.number).to eq organ_branch.number
        #     expect(Organ.first.organs.last.complement).to eq organ_branch.complement
        #     expect(Organ.first.organs.last.district).to eq "Novo Eldorado"
        #     expect(Organ.first.organs.last.city_id).to eq city.id
        #     expect(Organ.first.organs.last.state_id).to eq state.id
        # end

        scenario "invalid fields", js: true do
            visit new_organ_path
            click_button "Salvar"
            sleep 1
            expect(page).to have_content "Esfera não pode ficar em branco"
            expect(page).to have_content "Nome do orgão não pode ficar em branco"
            expect(page).to have_content "Telefone geral não pode ficar em branco"
            expect(page).to have_content "CNPJ não pode ficar em branco"
            expect(page).to have_content "CEP não pode ficar em branco"
            expect(page).to have_content "Logradouro não pode ficar em branco"
            expect(page).to have_content "Bairro não pode ficar em branco"
            expect(page).to have_content "Número não pode ficar em branco"
            expect(page).to have_content "Estado não pode ficar em branco"
            expect(page).to have_content "Cidade não pode ficar em branco"
            expect(page).to have_content "Nome do setor não pode ficar em branco"
            expect(page).to have_content "Nome completo do responsável não pode ficar em branco"
        end
    end
end
