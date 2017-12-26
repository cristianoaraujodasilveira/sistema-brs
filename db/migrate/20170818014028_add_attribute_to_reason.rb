class AddAttributeToReason < ActiveRecord::Migration
	def change
		add_column :bidding_resources, :resource_type, :integer
	end
end
