feature "Client Step 5 - Create" do

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
      client = build :client
      client_bank = build :client_bank, :client => client
      create(:proposal)

      visit new_client_path
      sleep 1

      text = Proposal.first.fantasy_name+' / '+Proposal.first.social_name+' / '+Proposal.first.cnpj

      select_from_chosen text, :from => "client[proposal_id]"

      page.find("#client_step_5").click
      sleep 1
      fill_in "client[client_banks_attributes][0][owner_account]", with: client_bank.owner_account
      fill_in "client[client_banks_attributes][0][bank_name]", with: client_bank.bank_name
      fill_in "client[client_banks_attributes][0][bank_code]", with: client_bank.bank_code
      fill_in "client[client_banks_attributes][0][agency_number]", with: client_bank.agency_number
      fill_in "client[client_banks_attributes][0][agency_name]", with: client_bank.agency_name
      fill_in "client[client_banks_attributes][0][operation]", with: client_bank.operation
      fill_in "client[client_banks_attributes][0][account_number]", with: client_bank.account_number

      select_from_chosen AccountBankType.first.name, :from => "client[client_banks_attributes][0][account_bank_type_id]"

      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Cliente cadastrado com sucesso"
      

      expect(Client.last.client_banks[0].owner_account).to eq client_bank.owner_account
      expect(Client.last.client_banks[0].bank_name).to eq client_bank.bank_name
      expect(Client.last.client_banks[0].bank_code).to eq client_bank.bank_code
      expect(Client.last.client_banks[0].agency_number).to eq client_bank.agency_number
      expect(Client.last.client_banks[0].agency_name).to eq client_bank.agency_name
      expect(Client.last.client_banks[0].operation).to eq client_bank.operation
      expect(Client.last.client_banks[0].account_number).to eq client_bank.account_number
      expect(Client.last.client_banks[0].account_bank_type_id).to eq AccountBankType.first.id
    end

  end
end
