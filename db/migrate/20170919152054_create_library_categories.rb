class CreateLibraryCategories < ActiveRecord::Migration
	def change
		create_table :library_categories do |t|
			t.string :name

			t.timestamps null: false
		end
		LibraryCategory.create([
			{name: 'Acordão'},
			{name: 'Artigos'},
			{name: 'Códigos'},
			{name: 'Constituição Estadual'},
			{name: 'Constituição Federal'},
			{name: 'Decisões democráticas'},
			{name: 'Decreto Estadual'},
			{name: 'Decreto Federal'},
			{name: 'Decreto Municipal'},
			{name: 'Dicionário'},
			{name: 'Doutrina'},
			{name: 'Estudo de caso'},
			{name: 'Instrução Normativa'},
			{name: 'Jurisprudência'},
			{name: 'Lei Complementar'},
			{name: 'Lei Estadual'},
			{name: 'Lei Federal'},
			{name: 'Lei Municipal'},
			{name: 'Lei Orgânica'},
			{name: 'Livros'},
			{name: 'Modelos de documento'},
			{name: 'Portaria'},
			{name: 'Resolução'},
			{name: 'Resolução Normativa'},
			{name: 'Revistas'},
			{name: 'Súmula'},
			{name: 'Tratados'},
			{name: 'Vídeos'}
			])
	end
end
