class CreateCalendarEventsUsers < ActiveRecord::Migration
	def change
		create_table :calendar_events_users do |t|
			t.references :calendar_event, index: true, foreign_key: true
			t.references :user, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
