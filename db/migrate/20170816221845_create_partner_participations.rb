class CreatePartnerParticipations < ActiveRecord::Migration
	def change
		create_table :partner_participations do |t|
			t.string :name

			t.timestamps null: false
		end
		PartnerParticipation.create([
			{ name: 'Participou'},
			{ name: 'Não quis participar'},
			{ name: 'Sem resposta'}
			])
	end
end
