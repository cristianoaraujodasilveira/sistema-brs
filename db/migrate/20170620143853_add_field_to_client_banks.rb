class AddFieldToClientBanks < ActiveRecord::Migration
	def change
		add_column :client_banks, :account_number, :string
	end
end
