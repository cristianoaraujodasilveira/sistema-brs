class CreateClientClients < ActiveRecord::Migration
	def change
		create_table :client_clients do |t|
			t.references :client, index: true, foreign_key: true
      		t.references :client_children, references: :clients
      		
			t.timestamps null: false
		end
	end
end
