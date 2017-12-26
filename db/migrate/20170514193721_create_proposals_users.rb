class CreateProposalsUsers < ActiveRecord::Migration
	def change
		create_table :proposals_users, id: false do |t|
			t.references :user, index: true, foreign_key: true
			t.references :proposal, index: true, foreign_key: true

			t.timestamps null: false
		end
	end
end
