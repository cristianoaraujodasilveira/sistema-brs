class CreateAccreditationPresentials < ActiveRecord::Migration
	def change
		create_table :accreditation_presentials do |t|
			t.string :name

			t.timestamps null: false
		end
		AccreditationPresential.create([
			{ name: 'Contrato consolidado' },
			{ name: 'RG dos Sócios' },
			{ name: 'Procuração' },
			{ name: 'RG procurador' },
			{ name: 'Certidão simplificada' },
			{ name: 'Declaração habilitação' },
			{ name: 'Declaração de ME / EPP' },
			{ name: 'CRC' },
			{ name: 'Cartão CNPJ' },
			{ name: 'Inscrição Estadual' },
			{ name: 'Inscrição Municipal' },
			{ name: 'CND FGTS' },
			{ name: 'CND Trabalhista' },
			{ name: 'Atestado de capacidade técnica' },
			{ name: 'Balanço patrimonial' },
			{ name: 'Índice de balanço' },
			{ name: 'Falência' },
			{ name: 'Inscrição no conselho' },
			{ name: 'Inscrição de RT' },
			{ name: 'Prova de vínculo' },
			{ name: 'Alvará de localização / funcionamento' },
			{ name: 'Dec. menor de idade' },
			{ name: 'Dec. fatos impeditivos / idoneidade' },
			{ name: 'Certificados' },
			{ name: 'Laudos' },
			{ name: 'Dec. Vistoria' },
			{ name: 'ANVISA' },
			])
	end
end
