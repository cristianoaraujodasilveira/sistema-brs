class CreateBidderStatuses < ActiveRecord::Migration
	def change
		create_table :bidder_statuses do |t|
			t.string :name

			t.timestamps null: false
		end
		BidderStatus.create([
			{ name: 'Desclassificado' },
			{ name: 'Inabilitado' },
			{ name: 'Inidôneo' },
			{ name: 'Outros' }
			])
	end
end
