class CreateMonthlyValues < ActiveRecord::Migration
	def change
		create_table :monthly_values do |t|
			t.references :proposal, index: true, foreign_key: true
			t.string :percentual_discounts
			t.text :observation

			t.timestamps null: false
		end
	end
end
