class CreateContracts < ActiveRecord::Migration
	def change
		create_table :contracts do |t|

			t.references :client, index: true, foreign_key: true
			t.string :title

			t.string :monthly_fixed_payment
			t.string :monthly_payment
			t.string :monthly_discount
			t.date :monthly_initial_date
			t.date :monthly_final_date

			t.string :comission_fixed_payment
			t.string :comission_payment
			t.string :comission_discount
			t.date :comission_initial_date
			t.date :comission_final_date

			t.string :fixed_value
			t.string :comission_value
			t.string :discount_value
			t.date :pre_established_initial_date
			t.date :pre_established_final_date
			t.boolean :undetermined

			t.text :draft_contact, :limit => 4294967295

			t.timestamps null: false
		end
	end
end
