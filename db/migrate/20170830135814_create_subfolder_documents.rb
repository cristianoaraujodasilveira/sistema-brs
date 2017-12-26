class CreateSubfolderDocuments < ActiveRecord::Migration
	def change
		create_table :subfolder_documents do |t|
			t.string :name
			t.references :client_document_type, index: true, foreign_key: true

			t.timestamps null: false
		end

		add_reference :client_documents, :subfolder_document, index: true, foreign_key: true

		SubfolderDocument.create([
			{ client_document_type_id: 1, name: 'Outros' },
			{ client_document_type_id: 1, name: 'Procuração Administrador' },
			{ client_document_type_id: 1, name: 'Identificação Sócios/Cônjuges' },
			{ client_document_type_id: 1, name: 'Contrato Social/Alterações/Instatuto' },

			{ client_document_type_id: 2, name: 'Outros' },
			{ client_document_type_id: 2, name: 'Certificados' },
			{ client_document_type_id: 2, name: 'Catálogos/Folder/Manuais' },
			{ client_document_type_id: 2, name: 'Atestados de Capacidade Técnica' },
			
			{ client_document_type_id: 3, name: 'Outros' },
			{ client_document_type_id: 3, name: 'Balanço patrimonial/Sped' },
			{ client_document_type_id: 3, name: 'Falência/Concordata/Recuperação Judicial' },
			{ client_document_type_id: 3, name: 'Índices de balanço' },
			{ client_document_type_id: 3, name: 'Cartório Distribuidor' },

			{ client_document_type_id: 4, name: 'Outros' },
			{ client_document_type_id: 4, name: 'CND FGTS' },
			{ client_document_type_id: 4, name: 'Insc. Federal' },
			{ client_document_type_id: 4, name: 'CND Federal' },
			{ client_document_type_id: 4, name: 'Insc. Estadual' },
			{ client_document_type_id: 4, name: 'CND Estadual' },
			{ client_document_type_id: 4, name: 'Insc. Municipal' },
			{ client_document_type_id: 4, name: 'CND Municipal' },
			{ client_document_type_id: 4, name: 'CND Trabalhista' },

			{ client_document_type_id: 6, name: 'Outros' },
			{ client_document_type_id: 6, name: 'Procuração' },
			{ client_document_type_id: 6, name: 'Formulário de cadastro' },
			{ client_document_type_id: 6, name: 'Contrato BRS/PARCEIRO' },

			])
	end
end
