class CreateProposalSituations < ActiveRecord::Migration
	def change
		create_table :proposal_situations do |t|
			t.string :name

			t.timestamps null: false
		end

		ProposalSituation.create([
			{name: 'Aprovada'},
			{name: 'Em Andamento'},
			{name: 'Declinada'}
			])
	end
end
