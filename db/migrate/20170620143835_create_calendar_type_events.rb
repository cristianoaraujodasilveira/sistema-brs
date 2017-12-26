class CreateCalendarTypeEvents < ActiveRecord::Migration
	def change
		create_table :calendar_type_events do |t|
			t.string :name

			t.timestamps null: false
		end

		CalendarTypeEvent.create([
			{name: 'Público'},
			{name: 'Privado'}
			])
	end
end
