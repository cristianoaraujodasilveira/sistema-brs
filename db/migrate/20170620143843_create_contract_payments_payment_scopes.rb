class CreateContractPaymentsPaymentScopes < ActiveRecord::Migration
	def change
		create_table :contract_payments_payment_scopes do |t|
			t.references :contract_payment, index: true, foreign_key: true
			t.references :payment_scope, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
