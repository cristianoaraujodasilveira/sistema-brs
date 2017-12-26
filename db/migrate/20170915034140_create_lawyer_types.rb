class CreateLawyerTypes < ActiveRecord::Migration
	def change
		create_table :lawyer_types do |t|
			t.string :name

			t.timestamps null: false
		end

		LawyerType.create([
			{ name: 'Celetista' },
			{ name: 'Contratado' },
			{ name: 'Terceirizado' },
			{ name: 'Sob-Demanda' },
			{ name: 'Correspondente' },
			])
	end
end
