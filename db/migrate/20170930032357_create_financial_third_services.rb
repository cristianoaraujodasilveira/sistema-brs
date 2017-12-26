class CreateFinancialThirdServices < ActiveRecord::Migration
	def change
		create_table :financial_third_services do |t|
			t.string :name

			t.timestamps null: false
		end
		FinancialThirdService.create([
			{name: 'Coleta'},
			{name: 'Entrega'},
			{name: 'PAC - AR'},
			{name: 'Sedex - AR'},
			{name: 'Sedex 10 - AR'},
			{name: 'Sedex 12 - AR'},
			{name: 'Simples - AR'},
			{name: 'Especial - AR'},
			{name: 'Diligência'},
			{name: 'Autenticação'},
			{name: 'Reconhecimento de firma'},
			{name: 'Procuração pública'},
			{name: 'Registro'},
			{name: 'Cartão de assinatura'},
			{name: 'Certidões'},
			{name: 'Arquivamento por folha'},
			{name: 'Outros'},
			])
	end
end
