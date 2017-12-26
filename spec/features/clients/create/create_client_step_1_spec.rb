feature "Client Step 1 - Create" do

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
    end

    scenario "Success", js: true do
      client = (build :client)
      create(:proposal)
      visit new_client_path
      sleep 1

      attach_file 'client[logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      text = Proposal.first.fantasy_name+' / '+Proposal.first.social_name+' / '+Proposal.first.cnpj

      select_from_chosen text, :from => "client[proposal_id]"

      fill_in "client[site]", with: client.site
      fill_in "client[municipal_registration]", with: client.municipal_registration
      fill_in "client[state_registration]", with: client.state_registration
      fill_in "client[municipal_registration]", with: client.municipal_registration

      check "client[bid_participant]"

      select_from_chosen ClientCompanySize.first.name, :from => "client[client_company_size_id]"
      select_from_chosen ClientType.first.name, :from => "client[client_type_id]"
      select_from_chosen ClientStatus.first.name, :from => "client[client_status_id]"

      sleep 1
      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Cliente cadastrado com sucesso"
      
      expect(Client.last.social_name).to eq Proposal.first.social_name
      expect(Client.last.fantasy_name).to eq Proposal.first.fantasy_name
      expect(Client.last.cnpj).to eq Proposal.first.cnpj
      expect(Client.last.site).to eq client.site
      expect(Client.last.municipal_registration).to eq client.municipal_registration
      expect(Client.last.state_registration).to eq client.state_registration
      expect(Client.last.bid_participant).to eq true

      expect(Client.last.client_company_size_id).to eq ClientCompanySize.first.id
      expect(Client.last.client_type_id).to eq ClientType.first.id
      expect(Client.last.client_status_id).to eq ClientStatus.first.id
    end

    scenario "Success - adding branch and client", js: true do
      client = (build :client)
      client_2 = (build :client)
      create_list(:proposal, 2)

      visit new_client_path

      click_button "Adicionar filial" 
      sleep 1

      attach_file 'client[logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      text = Proposal.first.fantasy_name+' / '+Proposal.first.social_name+' / '+Proposal.first.cnpj

      select_from_chosen text, :from => "client[proposal_id]"

      fill_in "client[site]", with: client.site
      fill_in "client[cnpj]", with: "97.754.147/5391-21"
      fill_in "client[municipal_registration]", with: client.municipal_registration
      fill_in "client[state_registration]", with: client.state_registration
      fill_in "client[municipal_registration]", with: client.municipal_registration

      check "client[bid_participant]"

      select_from_chosen ClientCompanySize.first.name, :from => "client[client_company_size_id]"
      select_from_chosen ClientType.first.name, :from => "client[client_type_id]"
      select_from_chosen ClientStatus.first.name, :from => "client[client_status_id]"

      attach_file 'client[clients_attributes][0][logo]', "#{Rails.root}/spec/support/files/logo.jpg"
      attach_file 'client[clients_attributes][0][stamp]', "#{Rails.root}/spec/support/files/logo.jpg"

      fill_in "client[clients_attributes][0][state_registration]", with: client_2.state_registration
      fill_in "client[clients_attributes][0][social_name]", with: Proposal.last.social_name
      fill_in "client[clients_attributes][0][fantasy_name]", with: Proposal.last.fantasy_name
      fill_in "client[clients_attributes][0][cnpj]", with: "97.754.147/5391-21"
      fill_in "client[clients_attributes][0][site]", with: client_2.site
      fill_in "client[clients_attributes][0][municipal_registration]", with: client_2.municipal_registration


      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Cliente cadastrado com sucesso"
      
      expect(Client.where(:client_id => nil).last.social_name).to eq Proposal.first.social_name
      expect(Client.where(:client_id => nil).last.fantasy_name).to eq Proposal.first.fantasy_name
      expect(Client.where(:client_id => nil).last.cnpj).to eq "97.754.147/5391-21"
      expect(Client.where(:client_id => nil).last.site).to eq client.site
      expect(Client.where(:client_id => nil).last.municipal_registration).to eq client.municipal_registration
      expect(Client.where(:client_id => nil).last.state_registration).to eq client.state_registration
      expect(Client.where(:client_id => nil).last.bid_participant).to eq true
      expect(Client.where(:client_id => nil).last.client_company_size_id).to eq ClientCompanySize.first.id
      expect(Client.where(:client_id => nil).last.client_type_id).to eq ClientType.first.id
      expect(Client.where(:client_id => nil).last.client_status_id).to eq ClientStatus.first.id

      expect(Client.where(:client_id => nil).last.clients[0].social_name).to eq Proposal.last.social_name
      expect(Client.where(:client_id => nil).last.clients[0].fantasy_name).to eq Proposal.last.fantasy_name
      expect(Client.where(:client_id => nil).last.clients[0].cnpj).to eq "97.754.147/5391-21"
      expect(Client.where(:client_id => nil).last.clients[0].site).to eq client_2.site
      expect(Client.where(:client_id => nil).last.clients[0].municipal_registration).to eq client_2.municipal_registration
      expect(Client.where(:client_id => nil).last.clients[0].state_registration).to eq client_2.state_registration
      expect(Client.where(:client_id => nil).last.clients[0].bid_participant).to eq false

    end

    scenario "invalid fields", js: true do
      visit new_client_path
      click_button "Salvar"
      sleep 1
      expect(page).to have_content "Razão social não pode ficar em branco"
      expect(page).to have_content "Nome fantasia não pode ficar em branco"
      expect(page).to have_content "CNPJ não pode ficar em branco"
    end
  end
end
