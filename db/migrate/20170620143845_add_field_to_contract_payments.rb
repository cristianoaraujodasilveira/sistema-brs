class AddFieldToContractPayments < ActiveRecord::Migration
	def change
		add_column :contract_payments, :all_scope, :boolean
	end
end
