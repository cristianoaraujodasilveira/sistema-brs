class CreateBiddingReadDeliveries < ActiveRecord::Migration
	def change
		create_table :bidding_read_deliveries do |t|
			t.string :name
			
			t.timestamps null: false
		end
		BiddingReadDelivery.create([
			{ name: 'Total'},
			{ name: 'Parcelada'}
			])
	end
end
