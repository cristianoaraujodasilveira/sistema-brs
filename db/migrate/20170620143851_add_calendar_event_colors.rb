class AddCalendarEventColors < ActiveRecord::Migration
	def change
		CalendarColor.create([
			{name: "Yellow", code: "#FFFF00"},
			{name: "Gold", code: "#FFD700"},
			{name: "LightGoldenrod", code: "#EEDD82"},
			{name: "Goldenrod", code: "#DAA520"},
			{name: "DarkGoldenrod", code: "#B8860B"},
			])
	end
end