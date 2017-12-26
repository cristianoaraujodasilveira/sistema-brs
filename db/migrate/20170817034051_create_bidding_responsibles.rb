class CreateBiddingResponsibles < ActiveRecord::Migration
	def change
		create_table :bidding_responsibles do |t|
			t.references :bidding, index: true, foreign_key: true
			t.references :user, index: true, foreign_key: true
			t.datetime :initial_date
			t.datetime :final_date

			t.timestamps null: false
		end
	end
end
