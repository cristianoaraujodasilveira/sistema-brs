class CreateRegistrationUnits < ActiveRecord::Migration
	def change
		create_table :registration_units do |t|

			t.references :organ, index: true, foreign_key: true
			t.string :name
			t.string :site
			t.string :zipcode
			t.string :address
			t.string :district
			t.string :number
			t.string :complement
			t.references :state, index: true, foreign_key: true
			t.references :city, index: true, foreign_key: true
			t.references :registration_unit, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
