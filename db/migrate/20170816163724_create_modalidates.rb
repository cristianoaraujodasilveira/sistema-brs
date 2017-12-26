class CreateModalidates < ActiveRecord::Migration
	def change
		create_table :modalidates do |t|
			t.string :name

			t.timestamps null: false
		end
		Modalidate.create([
			{name: 'Concorrência'},
			{name: 'Chamamento público'},
			{name: 'Credenciamento'},
			{name: 'Carta convite'},
			{name: 'Carta convite eletrônica'},
			{name: 'Pregão presencial'},
			{name: 'Pregão eletrônico'},
			{name: 'RDC - Presencial'},
			{name: 'RDC - Eletrônico'},
			{name: 'Consulta'},
			{name: 'Inexigibilidade'},
			{name: 'Dispensa'},
			{name: 'Tomada de preço'},
			{name: 'Cotep - Cotação de preço eletrônica'},
			{name: 'Leilão'},
			{name: 'Concurso'},
			{name: 'Outros'},
			])
	end
end
