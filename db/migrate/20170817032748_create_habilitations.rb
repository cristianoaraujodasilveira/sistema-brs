class CreateHabilitations < ActiveRecord::Migration
	def change
		create_table :habilitations do |t|
			t.string :name

			t.timestamps null: false
		end
		Habilitation.create([
			{ name: 'CRC' }, 
			{ name: 'RG dos Sócios			' }, 
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
			{ name: 'Contrato consolidado' }
			])
	end
end
