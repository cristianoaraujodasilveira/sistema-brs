class CreateTableClientsUsers < ActiveRecord::Migration
	def change
		create_table :clients_users, id: false do |t|
			t.references :client, index: true, foreign_key: true
			t.references :user, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
