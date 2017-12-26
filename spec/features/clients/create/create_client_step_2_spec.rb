feature "Client Step 2 - Create" do

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
      create(:proposal)

      visit new_client_path
      sleep 1
      page.find("#client_step_2").click
      fill_in "client[client_segment_attributes][words_keys_attributes][0][word]", with: "palavra chave 1"
      click_button "Adicionar palavra chave" 
      sleep 1
      page.find("#client_step_1").click
      sleep 1

      text = Proposal.first.fantasy_name+' / '+Proposal.first.social_name+' / '+Proposal.first.cnpj

      select_from_chosen text, :from => "client[proposal_id]"

      page.find("#client_step_2").click
      sleep 1
      fill_in "client[client_segment_attributes][name]", with: "nome segmento"
      fill_in "client[client_segment_attributes][products_services]", with: "produtos servicos"

      fill_in "client[client_segment_attributes][words_keys_attributes][0][word]", with: "palavra chave 1"

      fill_in "client[client_segment_attributes][words_keys_attributes][1][word]", with: "palavra chave 2"
      click_button "Salvar" 
      sleep 1

      expect(page).to have_content "Cliente cadastrado com sucesso"
      
      expect(Client.last.social_name).to eq Proposal.first.social_name
      expect(Client.last.fantasy_name).to eq Proposal.first.fantasy_name
      expect(Client.last.client_segment.name).to eq "nome segmento"
      expect(Client.last.client_segment.products_services).to eq "produtos servicos"
      expect(Client.last.client_segment.words_keys[0].word).to eq "palavra chave 1"
      expect(Client.last.client_segment.words_keys[1].word).to eq "palavra chave 2"
    end

  end
end
