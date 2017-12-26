class CreateProvenances < ActiveRecord::Migration
	def change
		create_table :provenances do |t|
			t.string :name

			t.timestamps null: false
		end
		Provenance.create([
			{ name: 'Nacional' },
			{ name: 'Importado' }
			])
	end
end
