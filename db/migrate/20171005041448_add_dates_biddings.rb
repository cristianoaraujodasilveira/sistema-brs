class AddDatesBiddings < ActiveRecord::Migration
	def change
		add_column :biddings, :catch_suspension_communication_date, :datetime
		add_column :biddings, :catch_reopened_date, :datetime
	end
end
