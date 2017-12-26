class CreateCalendarColors < ActiveRecord::Migration
	def change
		create_table :calendar_colors do |t|
			t.string :name
			t.string :code

			t.timestamps null: false
		end

		CalendarColor.create([
			{name: "Blue", code: "#0000FF"},
			{name: "BlueViolet", code: "#8A2BE2"},
			{name: "Brown", code: "#A52A2A"},
			{name: "BurlyWood", code: "#DEB887"},
			{name: "CadetBlue", code: "#5F9EA0"},
			{name: "Chartreuse", code: "#7FFF00"},
			{name: "Chocolate", code: "#D2691E"},
			{name: "Coral", code: "#FF7F50"},
			{name: "CornflowerBlue", code: "#6495ED"},
			{name: "Cornsilk", code: "#FFF8DC"},
			{name: "Crimson", code: "#DC143C"},
			{name: "Cyan", code: "#00FFFF"},
			{name: "DarkBlue", code: "#00008B"},
			{name: "DarkCyan", code: "#008B8B"},
			{name: "DarkRed", code: "#8B0000"},
			{name: "DarkSalmon", code: "#E9967A"},
			{name: "DarkSeaGreen", code: "#8FBC8F"},
			{name: "DarkSlateBlue", code: "#483D8B"},
			{name: "DarkSlateGray", code: "#2F4F4F"},
			{name: "DarkSlateGrey", code: "#2F4F4F"},
			{name: "DarkTurquoise", code: "#00CED1"},
			{name: "DarkViolet", code: "#9400D3"},
			{name: "DeepPink", code: "#FF1493"},
			{name: "DeepSkyBlue", code: "#00BFFF"},
			{name: "DimGray", code: "#696969"},
			{name: "DimGrey", code: "#696969"},
			{name: "DodgerBlue", code: "#1E90FF"},
			{name: "FireBrick", code: "#B22222"},
			{name: "FloralWhite", code: "#FFFAF0"},
			{name: "ForestGreen", code: "#228B22"},
			])
	end
end
