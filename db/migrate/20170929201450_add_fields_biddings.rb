class AddFieldsBiddings < ActiveRecord::Migration
	def change
		add_column :biddings, :ride_in_process, :boolean
		add_reference :biddings, :organ_ride, references: :organ

		add_column :bidding_proposals, :brs_comission, :string
		add_column :bidding_proposals, :consultant_comission, :string
		add_column :bidding_proposals, :intermediary_comission, :string
		add_column :bidding_proposals, :indication_pessoal, :string
		add_column :bidding_proposals, :indication_value, :string
		add_column :bidding_proposals, :brs_comission_final, :string
	end
end
