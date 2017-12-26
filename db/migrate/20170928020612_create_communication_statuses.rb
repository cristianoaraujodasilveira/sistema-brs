class CreateCommunicationStatuses < ActiveRecord::Migration
	def change
		create_table :communication_statuses do |t|
			t.string :name

			t.timestamps null: false
		end
		CommunicationStatus.create([
			{id: 1, name: 'Aguardando resposta'},
			{id: 2, name: 'Finalizado'},
			])
	end
end
