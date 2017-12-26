class AddProposalsToClient < ActiveRecord::Migration
	def change
		add_reference :clients, :proposal, index: true, foreign_key: true
	end
end
