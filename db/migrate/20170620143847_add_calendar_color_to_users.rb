class AddCalendarColorToUsers < ActiveRecord::Migration
	def change
		add_reference :users, :calendar_color, index: true, foreign_key: true
	end
end
