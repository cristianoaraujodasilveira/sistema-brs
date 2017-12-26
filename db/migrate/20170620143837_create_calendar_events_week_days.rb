class CreateCalendarEventsWeekDays < ActiveRecord::Migration
	def change
		create_table :calendar_events_weekdays, id: false do |t|
			t.references :calendar_event, index: true, foreign_key: true
			t.references :weekday, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
