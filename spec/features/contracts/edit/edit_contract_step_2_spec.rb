feature "Contract Step 2 - Edit" do

  context 'Visitor' do
    scenario "Access invalid" do
      contract = (create :contract)
      visit edit_contract_path contract

      expect(current_path).to eq new_session_path
    end
  end

  context 'Admin' do
    let(:user) { create :user}

    background do
      login user.email, user.password
    end

    scenario "Success", js: true do
      contract = create :contract
      create :client
      contract_payment = create :contract_payment
      contract_responsible_financial = create :contract_responsible_financial
      payment_scope = create(:payment_scope)

      contract = (create :contract)
      visit edit_contract_path contract

      sleep 1
      page.find("#contract_step_2").click

      select_from_chosen contract_payment.payment_form.name, :from => "contract[contract_payments_attributes][0][payment_form_id]"
      select_from_chosen contract_payment.payment_from.name, :from => "contract[contract_payments_attributes][0][payment_from_id]"
      select_from_chosen payment_scope.name, :from => "contract[contract_payments_attributes][0][payment_scope_ids][]"
      select_from_chosen contract_payment.payment_sugestion_day.name, :from => "contract[contract_payments_attributes][0][payment_sugestion_day_id]"

      fill_in "contract[contract_responsible_financials_attributes][0][name]", with: contract_responsible_financial.name
      fill_in "contract[contract_responsible_financials_attributes][0][office]", with: contract_responsible_financial.office
      fill_in "contract[contract_responsible_financials_attributes][0][department]", with: contract_responsible_financial.department
      fill_in "contract[contract_responsible_financials_attributes][0][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsible_financials_attributes][0][skype]", with: contract_responsible_financial.skype

      fill_in "contract[contract_responsible_financials_attributes][0][email_users_attributes][0][email]", with: "email@teste.com"

      click_button 'Salvar'
      sleep 1

      expect(page).to have_content "Contrato editado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id
      contract.reload

      expect(contract.contract_payments[0].payment_form.id).to eq contract_payment.payment_form.id
      expect(contract.contract_payments[0].payment_from.id).to eq contract_payment.payment_from.id
      expect(contract.contract_payments[0].payment_scopes[0].id).to eq payment_scope.id
      expect(contract.contract_payments[0].payment_sugestion_day.id).to eq contract_payment.payment_sugestion_day.id

      expect(contract.contract_responsible_financials[0].name).to eq contract_responsible_financial.name
      expect(contract.contract_responsible_financials[0].office).to eq contract_responsible_financial.office
      expect(contract.contract_responsible_financials[0].department).to eq contract_responsible_financial.department
      expect(contract.contract_responsible_financials[0].whatsapp).to eq "(21) 32131-2312"
      expect(contract.contract_responsible_financials[0].skype).to eq contract_responsible_financial.skype

      expect(contract.contract_responsible_financials[0].email_users[0].email).to eq "email@teste.com"

    end

    scenario "Success - adding payment", js: true do
      contract = build :contract
      contract_payment = create :contract_payment
      contract_payment_2 = create :contract_payment

      contract_responsible_financial = create :contract_responsible_financial

      contract = (create :contract)
      payment_scope = create(:payment_scope)
      payment_scope_2 = create(:payment_scope)

      visit edit_contract_path contract
      
      sleep 1
      page.find("#contract_step_2").click

      click_button 'Adicionar pagamento'
      sleep 1
      
      select_from_chosen contract_payment.payment_form.name, :from => "contract[contract_payments_attributes][0][payment_form_id]"
      select_from_chosen contract_payment.payment_from.name, :from => "contract[contract_payments_attributes][0][payment_from_id]"
      select_from_chosen payment_scope.name, :from => "contract[contract_payments_attributes][0][payment_scope_ids][]"
      select_from_chosen contract_payment.payment_sugestion_day.name, :from => "contract[contract_payments_attributes][0][payment_sugestion_day_id]"
      
      select_from_chosen contract_payment_2.payment_form.name, :from => "contract[contract_payments_attributes][1][payment_form_id]"
      select_from_chosen contract_payment_2.payment_from.name, :from => "contract[contract_payments_attributes][1][payment_from_id]"
      select_from_chosen payment_scope_2.name, :from => "contract[contract_payments_attributes][1][payment_scope_ids][]"
      select_from_chosen contract_payment_2.payment_sugestion_day.name, :from => "contract[contract_payments_attributes][1][payment_sugestion_day_id]"

      fill_in "contract[contract_responsible_financials_attributes][0][name]", with: contract_responsible_financial.name
      fill_in "contract[contract_responsible_financials_attributes][0][office]", with: contract_responsible_financial.office
      fill_in "contract[contract_responsible_financials_attributes][0][department]", with: contract_responsible_financial.department
      fill_in "contract[contract_responsible_financials_attributes][0][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsible_financials_attributes][0][skype]", with: contract_responsible_financial.skype

      fill_in "contract[contract_responsible_financials_attributes][0][email_users_attributes][0][email]", with: "email@teste.com"

      click_button 'Salvar'
      sleep 1

      expect(page).to have_content "Contrato editado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

      expect(contract.contract_payments[0].payment_form.id).to eq contract_payment.payment_form.id
      expect(contract.contract_payments[0].payment_from.id).to eq contract_payment.payment_from.id
      expect(contract.contract_payments[0].payment_scopes[0].id).to eq payment_scope.id
      expect(contract.contract_payments[0].payment_sugestion_day.id).to eq contract_payment.payment_sugestion_day.id

      expect(contract.contract_payments[1].payment_form.id).to eq contract_payment_2.payment_form.id
      expect(contract.contract_payments[1].payment_from.id).to eq contract_payment_2.payment_from.id
      expect(contract.contract_payments[1].payment_scopes[0].id).to eq payment_scope_2.id
      expect(contract.contract_payments[1].payment_sugestion_day.id).to eq contract_payment_2.payment_sugestion_day.id

      expect(contract.contract_responsible_financials[0].name).to eq contract_responsible_financial.name
      expect(contract.contract_responsible_financials[0].office).to eq contract_responsible_financial.office
      expect(contract.contract_responsible_financials[0].department).to eq contract_responsible_financial.department
      expect(contract.contract_responsible_financials[0].whatsapp).to eq "(21) 32131-2312"
      expect(contract.contract_responsible_financials[0].skype).to eq contract_responsible_financial.skype

      expect(contract.contract_responsible_financials[0].email_users[0].email).to eq "email@teste.com"
    end

    scenario "Success - adding responsible", js: true do
      contract = build :contract
      contract_payment = create :contract_payment

      contract_responsible_financial = create :contract_responsible_financial
      contract_responsible_financial_2 = create :contract_responsible_financial

      contract = (create :contract)
      payment_scope = create(:payment_scope)

      visit edit_contract_path contract

      sleep 1
      page.find("#contract_step_2").click

      click_button 'Adicionar responsável'
      sleep 1
      
      select_from_chosen contract_payment.payment_form.name, :from => "contract[contract_payments_attributes][0][payment_form_id]"
      select_from_chosen contract_payment.payment_from.name, :from => "contract[contract_payments_attributes][0][payment_from_id]"
      select_from_chosen payment_scope.name, :from => "contract[contract_payments_attributes][0][payment_scope_ids][]"
      select_from_chosen contract_payment.payment_sugestion_day.name, :from => "contract[contract_payments_attributes][0][payment_sugestion_day_id]"
  
      fill_in "contract[contract_responsible_financials_attributes][0][name]", with: contract_responsible_financial.name
      fill_in "contract[contract_responsible_financials_attributes][0][office]", with: contract_responsible_financial.office
      fill_in "contract[contract_responsible_financials_attributes][0][department]", with: contract_responsible_financial.department
      fill_in "contract[contract_responsible_financials_attributes][0][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsible_financials_attributes][0][skype]", with: contract_responsible_financial.skype

      fill_in "contract[contract_responsible_financials_attributes][0][email_users_attributes][0][email]", with: "email@teste.com"

      fill_in "contract[contract_responsible_financials_attributes][1][name]", with: contract_responsible_financial_2.name
      fill_in "contract[contract_responsible_financials_attributes][1][office]", with: contract_responsible_financial_2.office
      fill_in "contract[contract_responsible_financials_attributes][1][department]", with: contract_responsible_financial_2.department
      fill_in "contract[contract_responsible_financials_attributes][1][whatsapp]", with: "(21) 32131-2312"
      fill_in "contract[contract_responsible_financials_attributes][1][skype]", with: contract_responsible_financial_2.skype

      fill_in "contract[contract_responsible_financials_attributes][1][email_users_attributes][0][email]", with: "email@teste.com"

      click_button 'Salvar'
      sleep 1

      expect(page).to have_content "Contrato editado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

      contract.reload
      expect(contract.contract_payments[0].payment_form.id).to eq contract_payment.payment_form.id
      expect(contract.contract_payments[0].payment_from.id).to eq contract_payment.payment_from.id
      expect(contract.contract_payments[0].payment_scopes[0].id).to eq payment_scope.id
      expect(contract.contract_payments[0].payment_sugestion_day.id).to eq contract_payment.payment_sugestion_day.id

      expect(contract.contract_responsible_financials[0].name).to eq contract_responsible_financial.name
      expect(contract.contract_responsible_financials[0].office).to eq contract_responsible_financial.office
      expect(contract.contract_responsible_financials[0].department).to eq contract_responsible_financial.department
      expect(contract.contract_responsible_financials[0].whatsapp).to eq "(21) 32131-2312"
      expect(contract.contract_responsible_financials[0].skype).to eq contract_responsible_financial.skype

      expect(contract.contract_responsible_financials[0].email_users[0].email).to eq "email@teste.com"

      expect(contract.contract_responsible_financials[1].name).to eq contract_responsible_financial_2.name
      expect(contract.contract_responsible_financials[1].office).to eq contract_responsible_financial_2.office
      expect(contract.contract_responsible_financials[1].department).to eq contract_responsible_financial_2.department
      expect(contract.contract_responsible_financials[1].whatsapp).to eq "(21) 32131-2312"
      expect(contract.contract_responsible_financials[1].skype).to eq contract_responsible_financial_2.skype

      expect(contract.contract_responsible_financials[1].email_users[0].email).to eq "email@teste.com"
    end

  end
end
