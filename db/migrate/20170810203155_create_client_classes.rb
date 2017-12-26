class CreateClientClasses < ActiveRecord::Migration
	def change
		create_table :client_classes do |t|
			t.string :name

			t.timestamps null: false
		end
		add_reference :clients, :client_class, index: true, foreign_key: true
		add_reference :client_contacts, :client_class, index: true, foreign_key: true
	end
end
