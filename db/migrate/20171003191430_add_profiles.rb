class AddProfiles < ActiveRecord::Migration
	def change
		Profile.create([
			{name: 'Coord. Licitação'},
			{name: 'Coord. Jurídico'},
			{name: 'Coord. Financeiro'},
			{name: 'Terceiro'},
			{name: 'Licitação - Leitura'},
			{name: 'Licitação - Captura'},
			{name: 'Licitação - Participação'},
			{name: 'Advogado'}
			])
	end
end
