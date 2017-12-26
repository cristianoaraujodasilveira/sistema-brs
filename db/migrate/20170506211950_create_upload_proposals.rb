class CreateUploadProposals < ActiveRecord::Migration
	def change
		create_table :upload_proposals do |t|
			t.references :proposal, index: true, foreign_key: true
			t.attachment :file

			t.timestamps null: false
		end
	end
end
