feature "Client Step 1 - Edit" do

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
    end

    scenario "Success", js: true do
      client = create :client
      client_2 = (build :client)
      create(:proposal)

      visit edit_client_path client
      sleep 1
      attach_file 'client[logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      select_from_chosen ClientCompanySize.last.name, :from => "client[client_company_size_id]"
      select_from_chosen ClientType.last.name, :from => "client[client_type_id]"
      select_from_chosen ClientStatus.last.name, :from => "client[client_status_id]"

      sleep 1

      attach_file 'client[logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "client[proposal_id]"

      fill_in "client[site]", with: client_2.site
      fill_in "client[municipal_registration]", with: client_2.municipal_registration
      fill_in "client[state_registration]", with: client_2.state_registration

      check "client[bid_participant]"

      sleep 1
      click_button "Salvar" 
      sleep 1

      client.reload

      expect(page).to have_content "Cliente editado com sucesso"
      
      expect(client.social_name).to eq Proposal.last.social_name
      expect(client.fantasy_name).to eq Proposal.last.fantasy_name
      expect(client.site).to eq client_2.site
      expect(client.municipal_registration).to eq client_2.municipal_registration
      expect(client.state_registration).to eq client_2.state_registration
      expect(client.bid_participant).to eq true

      expect(client.client_company_size_id).to eq ClientCompanySize.last.id
      expect(client.client_type_id).to eq ClientType.last.id
      expect(client.client_status_id).to eq ClientStatus.last.id
    end

    scenario "Success - adding branch and client", js: true do
      client = create :client, :with_branchs
      client_2 = (build :client)
      client_3 = (create :client)
      client_4 = (create :client)
      create(:proposal)

      visit edit_client_path client
      sleep 1

      attach_file 'client[logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      check "client[bid_participant]"

      attach_file 'client[clients_attributes][0][logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[clients_attributes][0][stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "client[proposal_id]"

      fill_in "client[clients_attributes][0][social_name]", with: client_3.social_name
      fill_in "client[clients_attributes][0][fantasy_name]", with: client_3.fantasy_name
      fill_in "client[clients_attributes][0][cnpj]", with: client_3.cnpj
      fill_in "client[clients_attributes][0][site]", with: client_3.site
      fill_in "client[clients_attributes][0][municipal_registration]", with: client_3.municipal_registration
      fill_in "client[clients_attributes][0][state_registration]", with: client_3.state_registration

      click_button "Salvar" 
      sleep 1

      client.reload

      expect(page).to have_content "Cliente editado com sucesso"
      
      expect(client.social_name).to eq Proposal.last.social_name
      expect(client.fantasy_name).to eq Proposal.last.fantasy_name
      expect(client.site).to eq client.site
      expect(client.municipal_registration).to eq client.municipal_registration
      expect(client.state_registration).to eq client.state_registration
      expect(client.bid_participant).to eq true
      expect(client.client_company_size_id).to eq ClientCompanySize.first.id
      expect(client.client_type_id).to eq ClientType.first.id
      expect(client.client_status_id).to eq ClientStatus.first.id

      expect(client.clients[0].social_name).to eq client_3.social_name
      expect(client.clients[0].fantasy_name).to eq client_3.fantasy_name
      expect(client.clients[0].site).to eq client_3.site
      expect(client.clients[0].municipal_registration).to eq client_3.municipal_registration
      expect(client.clients[0].state_registration).to eq client_3.state_registration
      expect(client.clients[0].bid_participant).to eq true

    end

    scenario "invalid fields", js: true do
      client = create :client

      visit edit_client_path client
      fill_in "client[social_name]", with: ""
      fill_in "client[fantasy_name]", with: ""
      fill_in "client[cnpj]", with: ""

      click_button "Salvar"
      sleep 1
      expect(page).to have_content "Razão social não pode ficar em branco"
      expect(page).to have_content "Nome fantasia não pode ficar em branco"
      expect(page).to have_content "CNPJ não pode ficar em branco"
    end
  end
end
