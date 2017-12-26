class CreateResults < ActiveRecord::Migration
	def change
		create_table :results do |t|
			t.string :name

			t.timestamps null: false
		end
		Result.create([
			{ name: 'Deferido' },
			{ name: 'Indeferido' }
			])
	end
end
