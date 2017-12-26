class CreateProfiles < ActiveRecord::Migration
	def change
		create_table :profiles do |t|
			t.string :name

			t.timestamps null: false
		end

		Profile.create([
			{name: 'Administrador'},
			{name: 'Cliente'},
			{name: 'Comercial'},
			{name: 'Licitações'},
			{name: 'Jurídico'},
			{name: 'Financeiro'}
			])
	end
end
