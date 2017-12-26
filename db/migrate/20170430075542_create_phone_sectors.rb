class CreatePhoneSectors < ActiveRecord::Migration
	def change
		create_table :phone_sectors do |t|
			t.string :phone
			t.string :extension
			t.references :sector, index: true, foreign_key: true
			t.references :organ, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
