class CreateThirdTypes < ActiveRecord::Migration
	def change
		create_table :third_types do |t|
			t.string :name

			t.timestamps null: false
		end
		ThirdType.create([
			{name: 'Correios'},
			{name: 'Cartórios'},
			{name: 'Motoboys'},
			{name: 'Advogados'},
			{name: 'Diligeiros'},
			{name: 'Outros'}
			])
	end
end
