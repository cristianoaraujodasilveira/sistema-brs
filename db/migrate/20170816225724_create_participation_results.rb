class CreateParticipationResults < ActiveRecord::Migration
	def change
		create_table :participation_results do |t|
			t.string :name

			t.timestamps null: false
		end
		ParticipationResult.create([
			{ name: 'Ganhou'},
			{ name: 'Perdeu'},
			{ name: 'Em Andamento'}
			])
	end
end
