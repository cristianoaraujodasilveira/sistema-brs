class CreateSkypes < ActiveRecord::Migration
	def change
		create_table :skypes do |t|
			t.integer :skypetable_id, :null => false
			t.string :skypetable_type, :null => false, :limit => 30 
			t.string :skype

			t.timestamps null: false
		end
		add_index :skypes, [:skypetable_id, :skypetable_type]
	end
end
