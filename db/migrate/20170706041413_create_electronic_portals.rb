class CreateElectronicPortals < ActiveRecord::Migration
	def change
		create_table :electronic_portals do |t|
			t.references :organ, index: true, foreign_key: true
			t.string :value

			t.timestamps null: false
		end
	end
end
