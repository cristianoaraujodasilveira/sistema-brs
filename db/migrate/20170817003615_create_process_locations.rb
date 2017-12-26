class CreateProcessLocations < ActiveRecord::Migration
	def change
		create_table :process_locations do |t|
			t.string :name

			t.timestamps null: false
		end
		ProcessLocation.create([
			{ name: 'Setor licitação' },
			{ name: 'Arquivado' },
			{ name: 'Setor Financeiro' },
			{ name: 'Setor Jurídico' },
			{ name: 'Diretoria' }
			])
	end
end
