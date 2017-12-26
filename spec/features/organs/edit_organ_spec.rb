feature "Organ - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            organ = create(:organ)
            visit edit_organ_path organ
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            organ = create :organ
            visit edit_organ_path organ
            expect(current_path).to eq edit_organ_path organ
        end

        # scenario "Success", js: true do
        #     organ = create :organ
        #     organ_new = build :organ, :with_sectors

        #     state = create(:state, acronym: "MG")
        #     city = create(:city, name: "Contagem", state: state)

        #     visit edit_organ_path organ

        #     sleep 1
        #     select_from_chosen Sphere.first.name, :from => "organ[sphere_id]"
        #     fill_in "organ[name]", with: organ_new.name
        #     fill_in "organ[cnpj]", with: organ_new.cnpj
        #     fill_in "organ[site]", with: organ_new.site
        #     fill_in "organ[eletronic_portal]", with: organ_new.eletronic_portal
        #     fill_in "organ[email]", with: organ_new.email
        #     fill_in "organ[phone]", with: organ_new.phone
        #     fill_in "organ[zipcode]", with: "32341170"
        #     fill_in "organ[number]", with: organ_new.number
        #     sleep 2
        #     fill_in "organ[complement]", with: organ_new.complement
        #     fill_in "organ[identification_number]", with: organ_new.identification_number    
        #     fill_in "organ[observation]", with: organ_new.observation   

        #     fill_in "organ[sectors_attributes][0][name]", with: organ_new.sectors.last.name    
        #     fill_in "organ[sectors_attributes][0][responsible_name]", with: organ_new.sectors.last.responsible_name    
        #     sleep 1
        #     click_button "Salvar" 
        #     sleep 1

        #     expect(page).to have_content "Orgão editado com sucesso"
        #     expect(current_path).to eq edit_organ_path Organ.last
        #     expect(Organ.last.name).to eq organ_new.name
        #     expect(Organ.last.site).to eq organ_new.site
        #     expect(Organ.last.eletronic_portal).to eq organ_new.eletronic_portal
        #     expect(Organ.last.email).to eq organ_new.email
        #     expect(Organ.last.address).to eq "Rua Moassy"
        #     expect(Organ.last.number).to eq organ_new.number
        #     expect(Organ.last.complement).to eq organ_new.complement
        #     expect(Organ.last.district).to eq "Novo Eldorado"
        #     expect(Organ.last.city_id).to eq city.id
        #     expect(Organ.last.state_id).to eq state.id
        #     expect(Organ.last.sectors.last.name).to eq organ_new.sectors.last.name
        #     expect(Organ.last.sectors.last.responsible_name).to eq organ_new.sectors.last.responsible_name
        # end

    end
end
