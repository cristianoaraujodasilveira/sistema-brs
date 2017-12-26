feature "Contract Step 3 - Create" do

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

      visit new_contract_path
      sleep 1
      page.find("#contract_step_3").click

      fill_in "contract[monthly_fixed_payment]", with: contract.monthly_fixed_payment
      fill_in "contract[monthly_payment]", with: contract.monthly_payment
      fill_in "contract[monthly_discount]", with: contract.monthly_discount
      fill_in "contract[comission_fixed_payment]", with: contract.comission_fixed_payment
      fill_in "contract[comission_payment]", with: contract.comission_payment
      fill_in "contract[comission_discount]", with: contract.comission_discount
      fill_in "contract[comission_initial_date]", with: contract.comission_initial_date
      fill_in "contract[comission_final_date]", with: contract.comission_final_date
      fill_in "contract[fixed_value]", with: contract.fixed_value
      fill_in "contract[comission_value]", with: contract.comission_value
      fill_in "contract[discount_value]", with: contract.discount_value

      click_button 'Salvar'
      sleep 1

      expect(page).to have_content "Contrato cadastrado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

    end

    scenario "invalid fields", js: true do
      visit new_contract_path
      page.find("#contract_step_3").click
      click_button "Salvar"
      sleep 1
      expect(page).to have_content "Valor da mensalidade fixa"
      expect(page).to have_content "Valor da mensalidade"
      expect(page).to have_content "Valor da comissão fixa"
    end
  end
end
