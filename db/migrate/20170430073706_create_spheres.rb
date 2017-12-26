class CreateSpheres < ActiveRecord::Migration
	def change
		create_table :spheres do |t|
			t.string :name

			t.timestamps null: false
		end

		Sphere.create([
			{name: 'Municipal'},
			{name: 'Estadual'},
			{name: 'Federal'},
			{name: 'Privada'}
			])
	end
end
