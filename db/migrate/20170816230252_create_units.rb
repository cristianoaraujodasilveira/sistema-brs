class CreateUnits < ActiveRecord::Migration
	def change
		create_table :units do |t|
			t.string :name

			t.timestamps null: false
		end
		Unit.create([
			{ name: 'Unid' },
			{ name: 'Pct' },
			{ name: 'Serv' },
			{ name: 'Hora' },
			{ name: 'Mensal' },
			{ name: 'Anual' },
			{ name: 'Metro' },
			{ name: 'M2' },
			{ name: 'Fardo' },
			{ name: 'Litro' },
			{ name: 'Km' },
			{ name: 'Kg' },
			{ name: 'Tonelada' },
			{ name: 'ML' },
			{ name: 'Outro' }
			])
	end
end
