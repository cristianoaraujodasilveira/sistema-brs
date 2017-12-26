class CreateAttachments < ActiveRecord::Migration
	def change
		create_table :attachments do |t|
			t.integer :attachmentable_id, :null => false
			t.string :attachmentable_type, :null => false, :limit => 30 

			t.attachment :attachment
			t.integer :type

			t.timestamps null: false
		end
		add_index :attachments, [:attachmentable_id, :attachmentable_type]
	end
end
