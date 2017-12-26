feature "Calendar event - Edit" do

    context 'Visitor' do
        scenario "Access invalid" do
            calendar_event = (create :calendar_event)
            visit edit_calendar_event_path calendar_event

            expect(current_path).to eq new_session_path
        end
    end

    context 'Admin' do
        let(:profile) { create :profile, id: 1}
        let(:user) { create :user, :profile => profile}

        background do
            login user.email, user.password
        end

        scenario "Success", js: true do
            calendar_event = (create :calendar_event)
            calendar_event_new = (create :calendar_event)
            create_list(:weekday, 3)

            state = create(:state, acronym: "MG")
            city = create(:city, name: "Contagem", state: state)

            visit edit_calendar_event_path calendar_event
            select_from_chosen calendar_event_new.entity_class.name, :from => "calendar_event[entity_class_id]"
            select_from_chosen calendar_event_new.user.name, :from => "calendar_event[user_id]"

            fill_in "calendar_event[name]", with: calendar_event_new.name

            choose "calendar_event_calendar_type_event_id_2"
            check "calendar_event[shared]"

            fill_in "calendar_event[zipcode]", with: "32341170"
            fill_in "calendar_event[number]", with: calendar_event_new.number
            sleep 4
            fill_in "calendar_event[complement]", with: calendar_event_new.complement

            check "calendar_event[repeat]"
            select_from_chosen calendar_event_new.calendar_repetition.name, :from => "calendar_event[calendar_repetition_id]"

            fill_in "calendar_event[initial_date]", with: '26/09/1990'

            fill_in "calendar_event[observation]", with: calendar_event_new.observation

            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Evento editado com sucesso"

            expect(CalendarEvent.first.entity_class.id).to eq calendar_event_new.entity_class.id
            expect(CalendarEvent.first.user.id).to eq calendar_event_new.user.id
            expect(CalendarEvent.first.name).to eq calendar_event_new.name

            expect(CalendarEvent.first.calendar_type_event.id).to eq 2

            expect(CalendarEvent.first.address).to eq "Rua Moassy"
            expect(CalendarEvent.first.number).to eq calendar_event_new.number
            expect(CalendarEvent.first.complement).to eq calendar_event_new.complement
            expect(CalendarEvent.first.district).to eq "Novo Eldorado"
            expect(CalendarEvent.first.city_id).to eq city.id
            expect(CalendarEvent.first.state_id).to eq state.id

            expect(CalendarEvent.first.repeat).to eq true
            expect(CalendarEvent.first.calendar_repetition.id).to eq calendar_event_new.calendar_repetition.id
            expect(CalendarEvent.first.observation).to eq calendar_event_new.observation

        end

    end

    context "User" do

        scenario "Success", js:true do
            create_list(:profile, 2)
            user = create(:user, profile_id: 2)
            login user.email, user.password

            calendar_event = (create :calendar_event)

            visit edit_calendar_event_path calendar_event

            click_button "Salvar"
            sleep 1

            expect(page).to have_content "Evento editado com sucesso"

            expect(CalendarEvent.first.user.id).to eq calendar_event.user.id
        end

    end
end
