class CreateHonoraryForms < ActiveRecord::Migration
	def change
		create_table :honorary_forms do |t|
			t.string :name

			t.timestamps null: false
		end

		HonoraryForm.create([
			{ name: 'Hora' },
			{ name: 'Diária' },
			{ name: 'Semanal' },
			{ name: 'Quinzenal' },
			{ name: 'Mensalidade' },
			{ name: 'Por Demanda' },
			{ name: 'Por Diligência' },
			])
	end
end
