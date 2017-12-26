class AddLastLogoutUser < ActiveRecord::Migration
	def change
		add_column :users, :last_logout, :datetime
	end
end
