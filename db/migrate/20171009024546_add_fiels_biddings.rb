class AddFielsBiddings < ActiveRecord::Migration
	def change
		add_column :biddings, :catch_publication_date, :datetime
		add_column :biddings, :catch_bidding_id, :string
		add_column :biddings, :read_claritication_solicitation_date, :datetime
		add_column :biddings, :read_impugnment_solicitation_date, :datetime
	end
end
