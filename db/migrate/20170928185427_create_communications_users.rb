class CreateCommunicationsUsers < ActiveRecord::Migration
	def change
		create_table :communications_users do |t|
			t.references :communication, index: true
			t.references :user, index: true
		end
	end
end
