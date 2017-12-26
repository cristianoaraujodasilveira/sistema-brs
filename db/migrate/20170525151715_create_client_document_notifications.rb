class CreateClientDocumentNotifications < ActiveRecord::Migration
	def change
		create_table :client_document_notifications do |t|
			t.integer :days

			t.timestamps null: false
		end
		ClientDocumentNotification.create([
			{days: 10},
			{days: 15},
			{days: 20},
			{days: 30},
			{days: 45}
			])
	end
end
