class AddNewsProfiles < ActiveRecord::Migration
	def change
		Profile.create([
			{name: 'Coordenador'},
			{name: 'Consultor'},
			{name: 'Intermediador'},
			])
	end
end
