feature "Contract Step 3 - Create" do

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
      contract = (create :contract)
      contract_new = (build :contract)

      visit edit_contract_path contract

      sleep 1
      page.find("#contract_step_3").click

      fill_in "contract[monthly_fixed_payment]", with: contract_new.monthly_fixed_payment
      fill_in "contract[monthly_payment]", with: contract_new.monthly_payment
      fill_in "contract[monthly_discount]", with: contract_new.monthly_discount
      fill_in "contract[comission_fixed_payment]", with: contract_new.comission_fixed_payment
      fill_in "contract[comission_payment]", with: contract_new.comission_payment
      fill_in "contract[comission_discount]", with: contract_new.comission_discount
      fill_in "contract[comission_initial_date]", with: contract_new.comission_initial_date
      fill_in "contract[comission_final_date]", with: contract_new.comission_final_date
      fill_in "contract[fixed_value]", with: contract_new.fixed_value
      fill_in "contract[comission_value]", with: contract_new.comission_value
      fill_in "contract[discount_value]", with: contract_new.discount_value

      click_button 'Salvar'
      sleep 1

      expect(page).to have_content "Contrato editado com sucesso"
      expect(current_path).to eq edit_contract_path Contract.last.id

    end

    scenario "invalid fields", js: true do
      contract = (create :contract)
      visit edit_contract_path contract

      page.find("#contract_step_3").click
      fill_in "contract[monthly_fixed_payment]", with: ""
      fill_in "contract[monthly_payment]", with: ""
      fill_in "contract[comission_fixed_payment]", with: ""

      click_button "Salvar"
      sleep 1
      expect(page).to have_content "Valor da mensalidade fixa"
      expect(page).to have_content "Valor da mensalidade"
      expect(page).to have_content "Valor da comissão fixa"
    end
  end
end
