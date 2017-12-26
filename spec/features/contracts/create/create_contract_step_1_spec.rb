feature "Contract Step 1 - Create" do

  context 'Visitor' do
    scenario "Access invalid" do
      visit new_contract_path
      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user}

    background do
      login user.email, user.password
    end

    scenario "Success", js: true do
      contract = build :contract
      create :client
      contract_responsible = create :contract_responsible

      create(:proposal)

      visit new_contract_path
      sleep 1

      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "contract[proposal_id]"

      fill_in "contract[contract_responsibles_attributes][0][name]", with: contract_responsible.name
      fill_in "contract[contract_responsibles_attributes][0][office]", with: contract_responsible.office
      fill_in "contract[contract_responsibles_attributes][0][department]", with: contract_responsible.department
      fill_in "contract[contract_responsibles_attributes][0][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsibles_attributes][0][skype]", with: contract_responsible.skype

      fill_in "contract[contract_responsibles_attributes][0][email_users_attributes][0][email]", with: "email@teste.com"

      sleep 1
      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Contrato cadastrado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

      expect(Contract.last.proposal_id).to eq Proposal.last.id
      expect(Contract.last.title).to eq Proposal.last.title

      expect(Contract.last.contract_responsibles[0].name).to eq contract_responsible.name
      expect(Contract.last.contract_responsibles[0].office).to eq contract_responsible.office
      expect(Contract.last.contract_responsibles[0].department).to eq contract_responsible.department
      expect(Contract.last.contract_responsibles[0].whatsapp).to eq "(21) 32131-2312"
      expect(Contract.last.contract_responsibles[0].skype).to eq contract_responsible.skype

      expect(Contract.last.contract_responsibles[0].email_users[0].email).to eq "email@teste.com"

    end

    scenario "Success - adding responsible", js: true do
      contract = build :contract
      create :client
      contract_responsible = create :contract_responsible
      contract_responsible_2 = create :contract_responsible

      create(:proposal)

      visit new_contract_path
      sleep 1

      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "contract[proposal_id]"

      fill_in "contract[contract_responsibles_attributes][0][name]", with: contract_responsible.name
      fill_in "contract[contract_responsibles_attributes][0][office]", with: contract_responsible.office
      fill_in "contract[contract_responsibles_attributes][0][department]", with: contract_responsible.department
      fill_in "contract[contract_responsibles_attributes][0][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsibles_attributes][0][skype]", with: contract_responsible.skype

      fill_in "contract[contract_responsibles_attributes][0][email_users_attributes][0][email]", with: "email@teste.com"

      click_button "Adicionar responsável" 

      fill_in "contract[contract_responsibles_attributes][1][name]", with: contract_responsible_2.name
      fill_in "contract[contract_responsibles_attributes][1][office]", with: contract_responsible_2.office
      fill_in "contract[contract_responsibles_attributes][1][department]", with: contract_responsible_2.department
      fill_in "contract[contract_responsibles_attributes][1][whatsapp]", with: "(21) 22222-2312"
      fill_in "contract[contract_responsibles_attributes][1][skype]", with: contract_responsible_2.skype

      fill_in "contract[contract_responsibles_attributes][1][email_users_attributes][0][email]", with: "email@teste2.com"

      sleep 1
      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Contrato cadastrado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

      expect(Contract.last.proposal_id).to eq Proposal.last.id
      expect(Contract.last.title).to eq Proposal.last.title

      expect(Contract.last.contract_responsibles[0].name).to eq contract_responsible.name
      expect(Contract.last.contract_responsibles[0].office).to eq contract_responsible.office
      expect(Contract.last.contract_responsibles[0].department).to eq contract_responsible.department
      expect(Contract.last.contract_responsibles[0].whatsapp).to eq "(21) 32131-2312"
      expect(Contract.last.contract_responsibles[0].skype).to eq contract_responsible.skype

      expect(Contract.last.contract_responsibles[1].name).to eq contract_responsible_2.name
      expect(Contract.last.contract_responsibles[1].office).to eq contract_responsible_2.office
      expect(Contract.last.contract_responsibles[1].department).to eq contract_responsible_2.department
      expect(Contract.last.contract_responsibles[1].whatsapp).to eq "(21) 22222-2312"
      expect(Contract.last.contract_responsibles[1].skype).to eq contract_responsible_2.skype

      expect(Contract.last.contract_responsibles[1].email_users[0].email).to eq "email@teste2.com"
    end

    scenario "invalid fields", js: true do
      visit new_contract_path
      click_button "Salvar"
      sleep 1
      expect(page).to have_content "Responsável não é válido"
    end
  end
end
