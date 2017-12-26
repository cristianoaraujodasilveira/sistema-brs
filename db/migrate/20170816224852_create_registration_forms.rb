class CreateRegistrationForms < ActiveRecord::Migration
	def change
		create_table :registration_forms do |t|
			t.string :name

			t.timestamps null: false
		end
		RegistrationForm.create([
			{ name: 'Item'},
			{ name: 'Lote'},
			{ name: 'Grupo'}
			])
	end
end
