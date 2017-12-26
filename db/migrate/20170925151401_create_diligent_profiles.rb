class CreateDiligentProfiles < ActiveRecord::Migration
	def change
		create_table :diligent_profiles do |t|
			t.string :name

			t.timestamps null: false
		end
		DiligentProfile.create([
			{name: 'Advogado'},
			{name: 'Motoboy'},
			{name: 'Despachante'},
			{name: 'Engenheiro'},
			{name: 'Outros'}
			])
	end
end
