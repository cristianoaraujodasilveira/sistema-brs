class CreateEmails < ActiveRecord::Migration
	def change
		create_table :emails do |t|
			t.integer :emailtable_id, :null => false
			t.string :emailtable_type, :null => false, :limit => 30 
			t.string :email

			t.timestamps null: false
		end
		add_index :emails, [:emailtable_id, :emailtable_type]
	end
end
