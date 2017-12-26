class AddFantasyNameToVisitsReport < ActiveRecord::Migration
	def change
		add_column :visits_reports, :fantasy_name, :string
	end
end
