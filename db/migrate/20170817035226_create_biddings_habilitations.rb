class CreateBiddingsHabilitations < ActiveRecord::Migration
	def change
		create_table :biddings_habilitations do |t|
			t.references :bidding, index: true
			t.references :habilitation, index: true

			t.timestamps
		end
	end
end
