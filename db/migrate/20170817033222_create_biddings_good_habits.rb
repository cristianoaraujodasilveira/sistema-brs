class CreateBiddingsGoodHabits < ActiveRecord::Migration
	def change
		create_table :biddings_good_habits do |t|
			t.references :bidding, index: true
			t.references :good_habit, index: true

			t.timestamps
		end
	end
end
