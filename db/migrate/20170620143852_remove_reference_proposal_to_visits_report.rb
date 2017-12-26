class RemoveReferenceProposalToVisitsReport < ActiveRecord::Migration
	def change
		remove_reference(:visits_reports, :proposal, index: true, foreign_key: true)
	end
end
