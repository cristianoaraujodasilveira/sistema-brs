class CreateStates < ActiveRecord::Migration
	def change
		create_table :states do |t|
			t.string :name
			t.string :acronym

			t.timestamps null: false
		end

		State.create([
			{id: 1, name: 'Acre', acronym: 'AC'},
			{id: 2, name: 'Alagoas', acronym: 'AL'},
			{id: 3, name: 'Amapá', acronym: 'AP'},
			{id: 4, name: 'Amazônas', acronym: 'AM'},
			{id: 5, name: 'Bahia', acronym: 'BA'},
			{id: 6, name: 'Ceará', acronym: 'CE'},
			{id: 7, name: 'Distrito Federal', acronym: 'DF'},
			{id: 8, name: 'Espírito Santo', acronym: 'ES'},
			{id: 9, name: 'Goiás', acronym: 'GO'},
			{id: 10, name: 'Maranhão', acronym: 'MA'},
			{id: 11, name: 'Mato Grosso do Sul', acronym: 'MS'},
			{id: 12, name: 'Mato Grosso', acronym: 'MT'},
			{id: 13, name: 'Minas Gerais', acronym: 'MG'},
			{id: 14, name: 'Pará', acronym: 'PA'},
			{id: 15, name: 'Paraíba', acronym: 'PB'},
			{id: 16, name: 'Paraná', acronym: 'PR'},
			{id: 17, name: 'Pernambuco', acronym: 'PE'},
			{id: 18, name: 'Piauí', acronym: 'PI'},
			{id: 19, name: 'Rio de Janeiro', acronym: 'RJ'},
			{id: 20, name: 'Rio Grande do Norte', acronym: 'RN'},
			{id: 21, name: 'Rio Grande do Sul', acronym: 'RS'},
			{id: 22, name: 'Rondônia', acronym: 'RO'},
			{id: 23, name: 'Roraima', acronym: 'RR'},
			{id: 24, name: 'Santa Catarina', acronym: 'SC'},
			{id: 25, name: 'Sao Paulo', acronym: 'SP'},
			{id: 26, name: 'Sergipe', acronym: 'SE'},
			{id: 27, name: 'Tocantins', acronym: 'TO'}
		])
	end
end
