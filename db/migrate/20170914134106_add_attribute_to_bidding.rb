class AddAttributeToBidding < ActiveRecord::Migration
	def change
		add_column :biddings, :scheduling_date, :datetime
	end
end
