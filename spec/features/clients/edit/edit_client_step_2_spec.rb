feature "Client Step 2 - Edit" do

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
      text = Proposal.last.fantasy_name+' / '+Proposal.last.social_name+' / '+Proposal.last.cnpj
      select_from_chosen text, :from => "client[proposal_id]"

      page.find("#client_step_2").click
      sleep 1
      fill_in "client[client_segment_attributes][name]", with: "nome segmento"
      fill_in "client[client_segment_attributes][products_services]", with: "produtos servicos"
      fill_in "client[client_segment_attributes][words_keys_attributes][0][word]", with: "palavra chave 1"

      click_button "Salvar" 
      sleep 1
      client.reload
      expect(page).to have_content "Cliente editado com sucesso"
      
      expect(client.client_segment.name).to eq "nome segmento"
      expect(client.client_segment.products_services).to eq "produtos servicos"
      expect(client.client_segment.words_keys[0].word).to eq "palavra chave 1"
    end
  end
end
