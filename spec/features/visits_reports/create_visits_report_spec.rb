feature "Visits Report - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_visits_report_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            visit new_visits_report_path
            expect(current_path).to eq new_visits_report_path
        end

    #     scenario "Success", js: true do
    #         visits_report = (build :visits_report)
    #         create_list(:proposal, 2)
    #         create_list(:user, 2)
    #         create_list(:client, 2)
    #         create_list(:scale, 2)

    #         state = create(:state, acronym: "MG")
    #         city = create(:city, name: "Contagem", state: state)

    #         visit new_visits_report_path
    #         sleep 1
    #         fill_in "visits_report[social_name]", with: visits_report.social_name
            
    #         select_from_chosen Scale.first.name, :from => "visits_report[scale_id]"

    #         fill_in "visits_report[date_and_time]", with: visits_report.date_and_time

    #         check "visits_report[shared]"

    #         fill_in "visits_report[proposal_text]", with: visits_report.proposal_text

    #         fill_in "visits_report[subject]", with: visits_report.subject
    #         fill_in "visits_report[site]", with: visits_report.site
    #         fill_in "visits_report[responsible_name]", with: visits_report.responsible_name
    #         fill_in "visits_report[intermediary]", with: visits_report.intermediary
    #         fill_in "visits_report[contacts]", with: visits_report.contacts
    #         fill_in "visits_report[phone]", with: "(31) 99999-9999"
    #         fill_in "visits_report[email]", with: visits_report.email 
    #         fill_in "visits_report[segment]", with: visits_report.segment 
    #         fill_in "visits_report[cnpj]", with: "65.560.646/0001-79"
    #         fill_in "visits_report[products_and_services]", with: visits_report.products_and_services

    #         check "visits_report[bid_participant]"
    #         check "visits_report[participate_brs]"

    #         fill_in "visits_report[observation]", with: visits_report.observation
            
    #         select_from_chosen User.last.name, :from => "visits_report[user_id]"

    #         fill_in "visits_report[zipcode]", with: "32.341.170"
    #         fill_in "visits_report[number]", with: visits_report.number
    #         sleep 4
    #         fill_in "visits_report[complement]", with: visits_report.complement
            
    #         click_button "Salvar" 
    #         sleep 1

    #         expect(page).to have_content "Relatório da visita cadastrada com sucesso"
    #         expect(current_path).to eq visits_reports_path

    #         expect(VisitsReport.last.social_name).to eq visits_report.social_name
    #         expect(VisitsReport.last.scale_id).to eq Scale.first.id
    #         expect(VisitsReport.last.proposal_text).to eq visits_report.proposal_text
    #         expect(VisitsReport.last.subject).to eq visits_report.subject
    #         expect(VisitsReport.last.site).to eq visits_report.site
    #         expect(VisitsReport.last.responsible_name).to eq visits_report.responsible_name
    #         expect(VisitsReport.last.intermediary).to eq visits_report.intermediary
    #         expect(VisitsReport.last.contacts).to eq visits_report.contacts
    #         expect(VisitsReport.last.email).to eq visits_report.email
    #         expect(VisitsReport.last.segment).to eq visits_report.segment
            
    #         expect(VisitsReport.last.cnpj).to eq "65.560.646/0001-79"
    #         expect(VisitsReport.last.products_and_services).to eq visits_report.products_and_services
    #         expect(VisitsReport.last.bid_participant).to eq true
    #         expect(VisitsReport.last.shared).to eq true
    #         expect(VisitsReport.last.participate_brs).to eq true

    #         expect(VisitsReport.last.observation).to eq visits_report.observation

    #         expect(VisitsReport.last.user_id).to eq User.last.id
            
    #         expect(VisitsReport.last.zipcode).to eq "32.341-170"
    #         expect(VisitsReport.last.address).to eq "Rua Moassy"
    #         expect(VisitsReport.last.number).to eq visits_report.number
    #         expect(VisitsReport.last.complement).to eq visits_report.complement
    #         expect(VisitsReport.last.district).to eq "Novo Eldorado"
    #         expect(VisitsReport.last.city_id).to eq city.id
    #         expect(VisitsReport.last.state_id).to eq state.id

    #     end

    #     scenario "invalid fields", js: true do
    #         visit new_visits_report_path
    #         click_button "Salvar"
    #         sleep 1

    #         expect(page).to have_content "Responsável não pode ficar em branco"
    #         expect(page).to have_content "Razão Social não pode ficar em branco"
    #         expect(page).to have_content "Data e hora não pode ficar em branco"
    #         expect(page).to have_content "Porte não pode ficar em branco"
    #         expect(page).to have_content "Intermediador não pode ficar em branco"
    #         expect(page).to have_content "Telefone não pode ficar em branco"
    #         expect(page).to have_content "Email não pode ficar em branco"
    #         expect(page).to have_content "CNPJ não pode ficar em branco"
    #         expect(page).to have_content "CEP não pode ficar em branco"
    #         expect(page).to have_content "Logradouro não pode ficar em branco"
    #         expect(page).to have_content "Bairro não pode ficar em branco"
    #         expect(page).to have_content "Número não pode ficar em branco"
    #         expect(page).to have_content "Estado não pode ficar em branco"
    #         expect(page).to have_content "Cidade não pode ficar em branco"

    #     end
    end
end
