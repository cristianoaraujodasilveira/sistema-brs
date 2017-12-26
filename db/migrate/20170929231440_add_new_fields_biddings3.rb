class AddNewFieldsBiddings3 < ActiveRecord::Migration
	def change
		add_column :biddings, :residual_value_contract, :string
		add_column :biddings, :brs_comission, :string
		add_column :biddings, :date_payment_comission, :date
		add_column :biddings, :comission_received, :string
	end
end
