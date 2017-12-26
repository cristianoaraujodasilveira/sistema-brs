class CreatePhones < ActiveRecord::Migration
	def change
		create_table :phones do |t|
			t.integer :phonetable_id, :null => false
			t.string :phonetable_type, :null => false, :limit => 30 
			t.string :phone

			t.timestamps null: false
		end
		add_index :phones, [:phonetable_id, :phonetable_type]
	end
end
