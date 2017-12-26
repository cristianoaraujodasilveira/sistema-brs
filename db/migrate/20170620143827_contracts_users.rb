class ContractsUsers < ActiveRecord::Migration
	def change
		create_table :contracts_users, id: false do |t|
			t.references :user, index: true, foreign_key: true
			t.references :contract, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
