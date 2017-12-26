class CreateClientDocumentStatuses < ActiveRecord::Migration
	def change
		create_table :client_document_statuses do |t|
			t.string :name
			t.string :color

			t.timestamps null: false
		end
		ClientDocumentStatus.create([
			{name: 'Resolvido', color: '#009900'},
			{name: 'Pendente', color: '#FFFF00'},
			{name: 'Vencido', color: '#FF0000'}
			])
	end
end
