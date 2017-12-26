class CreateWeekdays < ActiveRecord::Migration
	def change
		create_table :weekdays do |t|
			t.string :name
			t.string :acronym
			t.integer :value

			t.timestamps null: false
		end

		Weekday.create([
			{name: 'Domingo', acronym: "D", value: 0},
			{name: 'Segunda', acronym: "S", value: 1},
			{name: 'Terça', acronym: "T", value: 2},
			{name: 'Quarta', acronym: "Q", value: 3},
			{name: 'Quinta', acronym: "Q", value: 4},
			{name: 'Sexta', acronym: "S", value: 5},
			{name: 'Sábado', acronym: "S", value: 6}
			])
	end
end
