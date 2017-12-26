class AddAndRenameClientDocumentTypes < ActiveRecord::Migration
	def change
		document = ClientDocumentType.find 1
		document.name = 'Habilitação Jurídica'
		document.save

		document = ClientDocumentType.find 2
		document.name = 'Habilitação Técnica'
		document.save

		document = ClientDocumentType.find 3
		document.name = 'Habilitação Econômico Financeira'
		document.save

		ClientDocumentType.create([
			{name: 'Habilitação Fiscal e Trabalhista'},
			{name: 'CRCs'},
			{name: 'Documentos BRS'}
			])
	end
end
