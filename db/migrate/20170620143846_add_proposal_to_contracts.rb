class AddProposalToContracts < ActiveRecord::Migration
	def change
		add_reference :contracts, :proposal, index: true, foreign_key: true
	end
end
