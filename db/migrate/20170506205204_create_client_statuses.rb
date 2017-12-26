class CreateClientStatuses < ActiveRecord::Migration
	def change
		create_table :client_statuses do |t|
			t.string :name

			t.timestamps null: false
		end

		ClientStatus.create([
			{name: 'Ativo - Estou trabalhando'},
			{name: 'Ativo inoperante - Não estou trabalhando mas estou recebendo'},
			{name: 'Inativo - Não estou prestando qualquer ação e nem recebendo'}
			])
	end
end
