class CreateEmailUsers < ActiveRecord::Migration
	def change
		create_table :email_users do |t|
			t.string :email
			t.references :user, index: true, foreign_key: true
			t.references :registration_unit, index: true, foreign_key: true
			t.references :responsible_registration_unit, index: true, foreign_key: true
			t.references :client_contability, index: true, foreign_key: true
			t.references :client_contact, index: true, foreign_key: true
			t.references :contract_responsible, index: true, foreign_key: true
			t.references :contract_responsible_financial, index: true, foreign_key: true
			t.references :entity_class_responsible, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
