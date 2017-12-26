class CreateNotifications < ActiveRecord::Migration
	def change
		create_table :notifications do |t|
			t.references :action_notification, index: true, foreign_key: true
			t.references :area_notification, index: true, foreign_key: true
			t.integer :sender_id
			t.integer :receiver_id
			
			t.string :text

			t.timestamps null: false
		end
	end
end
