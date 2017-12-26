class CreateContractPayments < ActiveRecord::Migration
	def change
		create_table :contract_payments do |t|

			t.references :contract, index: true, foreign_key: true
			t.references :payment_form, index: true, foreign_key: true
			t.references :payment_from, index: true, foreign_key: true
			t.references :payment_sugestion_day, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
