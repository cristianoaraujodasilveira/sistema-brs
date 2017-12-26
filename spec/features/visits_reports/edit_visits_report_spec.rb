feature "Visits Report - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            visits_report = create :visits_report
            visit edit_visits_report_path visits_report
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success" do
            visits_report = create :visits_report
            visit edit_visits_report_path visits_report
            expect(current_path).to eq edit_visits_report_path visits_report
        end

    #     scenario "Success", js: true do
    #         visits_report = create :visits_report
    #         visits_report_new = build :visits_report
    #         create_list(:proposal, 2)
    #         create_list(:user, 2)
    #         create_list(:client, 2)
    #         create_list(:scale, 2)

    #         state = create(:state, acronym: "MG")
    #         city = create(:city, name: "Contagem", state: state)
    
    #         visit edit_visits_report_path visits_report
    #         sleep 1
    #         fill_in "visits_report[social_name]", with: visits_report_new.social_name
    
    #         select_from_chosen Scale.first.name, :from => "visits_report[scale_id]"

    #         fill_in "visits_report[date_and_time]", with: visits_report_new.date_and_time

    #         fill_in "visits_report[proposal_text]", with: visits_report_new.proposal_text

    #         fill_in "visits_report[subject]", with: visits_report_new.subject
    #         fill_in "visits_report[site]", with: visits_report_new.site
    #         fill_in "visits_report[responsible_name]", with: visits_report_new.responsible_name
    #         fill_in "visits_report[intermediary]", with: visits_report_new.intermediary
    #         fill_in "visits_report[contacts]", with: visits_report_new.contacts
    #         fill_in "visits_report[phone]", with: "(31) 99999-9999"
    #         fill_in "visits_report[email]", with: visits_report_new.email 
    #         fill_in "visits_report[segment]", with: visits_report_new.segment 
    #         fill_in "visits_report[cnpj]", with: "65.560.646/0001-79"
    #         fill_in "visits_report[products_and_services]", with: visits_report_new.products_and_services

    #         check "visits_report[bid_participant]"
    #         check "visits_report[participate_brs]"

    #         fill_in "visits_report[observation]", with: visits_report_new.observation
    
    #         select_from_chosen User.last.name, :from => "visits_report[user_id]"

    #         fill_in "visits_report[zipcode]", with: "32.341-170"
    #         fill_in "visits_report[number]", with: visits_report_new.number
    #         sleep 4
    #         fill_in "visits_report[complement]", with: visits_report_new.complement
    
    #         click_button "Salvar" 
    #         sleep 1

    #         expect(page).to have_content "Relatório da visita editada com sucesso"
    #         expect(current_path).to eq edit_visits_report_path visits_report

    #         expect(VisitsReport.first.social_name).to eq visits_report_new.social_name
    #         expect(VisitsReport.first.scale_id).to eq Scale.first.id
    #         expect(VisitsReport.first.proposal_text).to eq visits_report_new.proposal_text
    #         expect(VisitsReport.first.subject).to eq visits_report_new.subject
    #         expect(VisitsReport.first.site).to eq visits_report_new.site
    #         expect(VisitsReport.first.responsible_name).to eq visits_report_new.responsible_name
    #         expect(VisitsReport.first.intermediary).to eq visits_report_new.intermediary
    #         expect(VisitsReport.first.contacts).to eq visits_report_new.contacts
    #         expect(VisitsReport.first.phone).to eq "(31) 99999-9999"
    #         expect(VisitsReport.first.email).to eq visits_report_new.email
    #         expect(VisitsReport.first.segment).to eq visits_report_new.segment
    
    #         expect(VisitsReport.first.cnpj).to eq "65.560.646/0001-79"
    #         expect(VisitsReport.first.products_and_services).to eq visits_report_new.products_and_services
    #         expect(VisitsReport.first.bid_participant).to eq true
    #         expect(VisitsReport.first.participate_brs).to eq true

    #         expect(VisitsReport.first.observation).to eq visits_report_new.observation

    #         expect(VisitsReport.last.user_id).to eq User.last.id
    
    #         expect(VisitsReport.first.zipcode).to eq "32.341-170"
    #         expect(VisitsReport.first.address).to eq "Rua Moassy"
    #         expect(VisitsReport.first.number).to eq visits_report_new.number
    #         expect(VisitsReport.first.complement).to eq visits_report_new.complement
    #         expect(VisitsReport.first.district).to eq "Novo Eldorado"
    #         expect(VisitsReport.first.city_id).to eq city.id
    #         expect(VisitsReport.first.state_id).to eq state.id

    #     end
end
end
