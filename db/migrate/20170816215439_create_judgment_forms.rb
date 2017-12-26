class CreateJudgmentForms < ActiveRecord::Migration
	def change
		create_table :judgment_forms do |t|
			t.string :name

			t.timestamps null: false
		end
		JudgmentForm.create([
			{ name: 'Menor preço por item'},
			{ name: 'Menor desconto por item'},
			{ name: 'Maior desconto por item'},
			{ name: 'Menor preço por Lote Unitário'},
			{ name: 'Maior desconto por Lote Unitário'},
			{ name: 'Menor preço por Lote Global'},
			{ name: 'Maior desconto por Lote Global'},
			{ name: 'Menor preço por Grupo'},
			{ name: 'Maior desconto por grupo'},
			{ name: 'Menor taxa de administração'},
			{ name: 'Maior desconto na tabela'},
			{ name: 'Maior lance'},
			{ name: 'Melhor técnica'},
			{ name: 'Melhor técnica e preço'},
			{ name: 'Outros'},
			])
	end
end
