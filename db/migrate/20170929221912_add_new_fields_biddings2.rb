class AddNewFieldsBiddings2 < ActiveRecord::Migration
	def change
		add_column :biddings, :contract_number, :string
		add_column :biddings, :contract_value, :string
		add_column :biddings, :initial_date, :date
		add_column :biddings, :final_date, :date
		add_column :biddings, :percent, :string
	end
end
