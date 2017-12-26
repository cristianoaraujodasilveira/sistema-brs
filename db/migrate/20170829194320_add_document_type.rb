class AddDocumentType < ActiveRecord::Migration
	def change
		ClientDocumentType.create([
			{ name: 'Outros' }
			])
	end
end
