class CreateEmailSectors < ActiveRecord::Migration
	def change
		create_table :email_sectors do |t|
			t.string :email
			t.references :sector, index: true, foreign_key: true
			t.references :organ, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end