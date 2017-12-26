feature "Client Step 3 - Edit" do

  context 'Visitor' do
    scenario "Access invalid" do
      client = (create :client)
      visit edit_client_path client
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

    scenario "Success", js: true do
      client = create :client
      client_contability = build :client_contability, :client => client
      create(:proposal)

      visit edit_client_path client
      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "client[proposal_id]"
      page.find("#client_step_3").click
      sleep 1
      fill_in "client[client_contability_attributes][name]", with: client_contability.name
      fill_in "client[client_contability_attributes][zipcode]", with: "32.341-170"
      fill_in "client[client_contability_attributes][number]", with: client_contability.number
      sleep 5
      fill_in "client[client_contability_attributes][complement]", with: client_contability.complement

      fill_in "client[client_contability_attributes][contability_contacts_attributes][0][name]", with: "nome teste 1"
      fill_in "client[client_contability_attributes][contability_secondary_contacts_attributes][0][name]", with: "nome teste 2"
      fill_in "client[client_contability_attributes][email_users_attributes][0][email]", with: "teste@teste.com"

      click_button "Salvar" 
      sleep 1
      client.reload
      expect(page).to have_content "Cliente editado com sucesso"
      
      expect(client.social_name).to eq Proposal.last.social_name
      expect(client.fantasy_name).to eq Proposal.last.fantasy_name

      expect(client.client_contability.name).to eq client_contability.name
      expect(client.client_contability.zipcode).to eq "32.341-170"
      expect(client.client_contability.address).to eq "Rua Moassy"
      expect(client.client_contability.district).to eq "Novo Eldorado"
      expect(client.client_contability.number).to eq client_contability.number
      expect(client.client_contability.complement).to eq client_contability.complement

      expect(client.client_contability.contability_contacts[0].name).to eq "nome teste 1"
      expect(client.client_contability.contability_secondary_contacts[0].name).to eq "nome teste 2"
      expect(client.client_contability.email_users[0].email).to eq "teste@teste.com"
    end
  end
end
