feature "Calendar event - Create" do

    context 'Visitor' do
        scenario "Access invalid" do
            visit new_calendar_event_path
            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:user) { create :user}

        background do
            login user.email, user.password
        end

        scenario "Success", js: true do
            calendar_event = build :calendar_event
            create_list(:weekday, 3)

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit new_calendar_event_path
            select_from_chosen calendar_event.entity_class.name, :from => "calendar_event[entity_class_id]"
            fill_in "calendar_event[name]", with: calendar_event.name
            select_from_chosen calendar_event.user.name, :from => "calendar_event[user_id]"

            choose "calendar_event_calendar_type_event_id_1"
            check "calendar_event[shared]"

            fill_in "calendar_event[zipcode]", with: "32341170"
            fill_in "calendar_event[number]", with: calendar_event.number
            sleep 4
            fill_in "calendar_event[complement]", with: calendar_event.complement

            check "calendar_event[repeat]"
            select_from_chosen calendar_event.calendar_repetition.name, :from => "calendar_event[calendar_repetition_id]"

            fill_in "calendar_event[initial_date]", with: '26/09/1990'
            fill_in "calendar_event[observation]", with: calendar_event.observation

            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Evento cadastrado com sucesso"

            expect(CalendarEvent.last.entity_class.id).to eq calendar_event.entity_class.id
            expect(CalendarEvent.last.user.id).to eq calendar_event.user.id
            expect(CalendarEvent.last.name).to eq calendar_event.name

            expect(CalendarEvent.last.calendar_type_event.id).to eq 1

            expect(CalendarEvent.last.address).to eq "Rua Moassy"
            expect(CalendarEvent.last.number).to eq calendar_event.number
            expect(CalendarEvent.last.complement).to eq calendar_event.complement
            expect(CalendarEvent.last.district).to eq "Novo Eldorado"
            expect(CalendarEvent.last.city_id).to eq city.id
            expect(CalendarEvent.last.state_id).to eq state.id

            expect(CalendarEvent.last.repeat).to eq true
            expect(CalendarEvent.last.calendar_repetition.id).to eq calendar_event.calendar_repetition.id
            expect(CalendarEvent.last.observation).to eq calendar_event.observation

        end

        scenario "invalid fields" do
            visit new_calendar_event_path
            click_button "Salvar"
            sleep 1
            expect(page).to have_content "Dia não pode ficar em branco"
        end
    end

    context "User" do

        scenario "Success", js: true do
            create_list(:profile, 2)
            user = create(:user, profile_id: 2)
            login user.email, user.password

            calendar_event = build :calendar_event
            create_list(:weekday, 3)

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit new_calendar_event_path
            select_from_chosen calendar_event.entity_class.name, :from => "calendar_event[entity_class_id]"

            fill_in "calendar_event[name]", with: calendar_event.name

            choose "calendar_event_calendar_type_event_id_1"
            check "calendar_event[shared]"

            fill_in "calendar_event[zipcode]", with: "32341170"
            fill_in "calendar_event[number]", with: calendar_event.number
            sleep 4
            fill_in "calendar_event[complement]", with: calendar_event.complement

            check "calendar_event[repeat]"
            select_from_chosen calendar_event.calendar_repetition.name, :from => "calendar_event[calendar_repetition_id]"

            fill_in "calendar_event[initial_date]", with: '26/09/1990'

            fill_in "calendar_event[observation]", with: calendar_event.observation

            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Evento cadastrado com sucesso"

            expect(CalendarEvent.last.entity_class.id).to eq calendar_event.entity_class.id
            expect(CalendarEvent.last.user.id).to eq user.id
            expect(CalendarEvent.last.name).to eq calendar_event.name

            expect(CalendarEvent.last.calendar_type_event.id).to eq 1

            expect(CalendarEvent.last.address).to eq "Rua Moassy"
            expect(CalendarEvent.last.number).to eq calendar_event.number
            expect(CalendarEvent.last.complement).to eq calendar_event.complement
            expect(CalendarEvent.last.district).to eq "Novo Eldorado"
            expect(CalendarEvent.last.city_id).to eq city.id
            expect(CalendarEvent.last.state_id).to eq state.id

            expect(CalendarEvent.last.repeat).to eq true
            expect(CalendarEvent.last.calendar_repetition.id).to eq calendar_event.calendar_repetition.id
            expect(CalendarEvent.last.observation).to eq calendar_event.observation

        end

    end
end
