class CreateResponsibleRegistrationUnits < ActiveRecord::Migration
	def change
		create_table :responsible_registration_units do |t|
			t.references :registration_unit, index: true, foreign_key: true
			t.string :name
			t.string :office
			t.string :department
			t.string :whatsapp
			t.string :skype

			t.timestamps null: false
		end
	end
end
