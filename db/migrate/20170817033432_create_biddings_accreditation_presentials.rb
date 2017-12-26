class CreateBiddingsAccreditationPresentials < ActiveRecord::Migration
	def change
		create_table :biddings_accreditation_presentials do |t|
			t.belongs_to :bidding
			t.belongs_to :accreditation_presential

			t.timestamps
		end
		add_index :biddings_accreditation_presentials, :bidding_id, name: "bidding_id"
		add_index :biddings_accreditation_presentials, :accreditation_presential_id, name: "accreditation_id"
	end
end
