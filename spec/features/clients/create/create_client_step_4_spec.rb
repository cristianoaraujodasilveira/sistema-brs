feature "Client Step 4 - Create" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit new_client_path
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
      client = build :client
      client_contact = build :client_contact, :client => client
      client_contact_2 = build :client_contact, :client => client
      create(:proposal)
      
      visit new_client_path
      sleep 1

      text = Proposal.first.fantasy_name+' / '+Proposal.first.social_name+' / '+Proposal.first.cnpj

      select_from_chosen text, :from => "client[proposal_id]"

      page.find("#client_step_4").click
      sleep 1

      # Comercial
      fill_in "client[client_contacts_attributes][0][zipcode]", with: "32.341-170"
      fill_in "client[client_contacts_attributes][0][number]", with: client_contact.number
      sleep 3
      fill_in "client[client_contacts_attributes][0][complement]", with: client_contact.complement
      fill_in "client[client_contacts_attributes][0][responsible_name]", with: client_contact.responsible_name
      fill_in "client[client_contacts_attributes][0][office]", with: client_contact.office
      fill_in "client[client_contacts_attributes][0][department]", with: client_contact.department
      fill_in "client[client_contacts_attributes][0][whatsapp]", with: "(31) 44124-1241"
      fill_in "client[client_contacts_attributes][0][skype]", with: client_contact.skype

      fill_in "client[client_contacts_attributes][0][email_users_attributes][0][email]", with: "email1@teste.com"

      # Fiscal
      fill_in "client[client_contacts_attributes][1][zipcode]", with: "32.341-170"
      fill_in "client[client_contacts_attributes][1][number]", with: client_contact_2.number
      sleep 3
      fill_in "client[client_contacts_attributes][1][complement]", with: client_contact_2.complement
      fill_in "client[client_contacts_attributes][1][responsible_name]", with: client_contact_2.responsible_name
      fill_in "client[client_contacts_attributes][1][office]", with: client_contact_2.office
      fill_in "client[client_contacts_attributes][1][department]", with: client_contact_2.department
      fill_in "client[client_contacts_attributes][1][whatsapp]", with: "(31) 44124-1243"
      fill_in "client[client_contacts_attributes][1][skype]", with: client_contact_2.skype

      fill_in "client[client_contacts_attributes][1][email_users_attributes][0][email]", with: "email2@teste.com"

      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Cliente cadastrado com sucesso"
      

      expect(Client.last.client_contacts[0].zipcode).to eq "32.341-170"
      expect(Client.last.client_contacts[0].address).to eq "Rua Moassy"
      expect(Client.last.client_contacts[0].district).to eq "Novo Eldorado"
      expect(Client.last.client_contacts[0].number).to eq client_contact.number
      expect(Client.last.client_contacts[0].complement).to eq client_contact.complement
      expect(Client.last.client_contacts[0].responsible_name).to eq client_contact.responsible_name
      expect(Client.last.client_contacts[0].office).to eq client_contact.office
      expect(Client.last.client_contacts[0].department).to eq client_contact.department
      expect(Client.last.client_contacts[0].whatsapp).to eq "(31) 44124-1241"
      expect(Client.last.client_contacts[0].skype).to eq client_contact.skype

      expect(Client.last.client_contacts[0].email_users[0].email).to eq "email1@teste.com"

      expect(Client.last.client_contacts[1].zipcode).to eq "32.341-170"
      expect(Client.last.client_contacts[1].address).to eq "Rua Moassy"
      expect(Client.last.client_contacts[1].district).to eq "Novo Eldorado"
      expect(Client.last.client_contacts[1].number).to eq client_contact_2.number
      expect(Client.last.client_contacts[1].complement).to eq client_contact_2.complement
      expect(Client.last.client_contacts[1].responsible_name).to eq client_contact_2.responsible_name
      expect(Client.last.client_contacts[1].office).to eq client_contact_2.office
      expect(Client.last.client_contacts[1].department).to eq client_contact_2.department
      expect(Client.last.client_contacts[1].whatsapp).to eq "(31) 44124-1243"
      expect(Client.last.client_contacts[1].skype).to eq client_contact_2.skype

      expect(Client.last.client_contacts[1].email_users[0].email).to eq "email2@teste.com"
    end

  end
end
