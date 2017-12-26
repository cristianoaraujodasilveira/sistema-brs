class CreateOrgansPortals < ActiveRecord::Migration
	def change
		create_table :organs_portals do |t|
			t.references :organ, index: true
			t.references :portal, index: true
		end
	end
end
