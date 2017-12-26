class AddVisitsReportToProposals < ActiveRecord::Migration
	def change
		add_reference :proposals, :visits_report, index: true, foreign_key: true
	end
end
