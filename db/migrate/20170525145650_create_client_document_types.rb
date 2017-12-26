class CreateClientDocumentTypes < ActiveRecord::Migration
	def change
		create_table :client_document_types do |t|
			t.string :name

			t.timestamps null: false
		end
		ClientDocumentType.create([
			{name: 'Documentos Primários'},
			{name: 'CRCs'},
			{name: 'Documentos BRS'}
			])
	end
end
