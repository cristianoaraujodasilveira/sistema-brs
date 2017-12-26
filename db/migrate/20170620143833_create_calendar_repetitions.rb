class CreateCalendarRepetitions < ActiveRecord::Migration
	def change
		create_table :calendar_repetitions do |t|
			t.string :name

			t.timestamps null: false
		end

		CalendarRepetition.create([
			{name: 'No próximo dia'},
			{name: 'Diariamente'},
			{name: 'Semanalmente'},
			{name: 'Mensalmente'},
			{name: 'Anualmente'},
			{name: 'Dia da semana específico'}
			])
	end
end
