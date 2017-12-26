class CreateObservations < ActiveRecord::Migration
	def change
		create_table :observations do |t|
			t.integer :observationtable_id, :null => false
			t.string :observationtable_type, :null => false, :limit => 30 
			t.references :user, index: true, foreign_key: true
			t.text :observation
			t.integer :type

			t.timestamps null: false
		end
		add_index :observations, [:observationtable_id, :observationtable_type], :name => 'my_index'
	end
end
