class CreateBiddingsUsers < ActiveRecord::Migration
	def change
		create_table :biddings_users do |t|
			t.references :bidding, index: true
			t.references :user, index: true

			t.timestamps
		end
	end
end
