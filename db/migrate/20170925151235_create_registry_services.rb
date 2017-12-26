class CreateRegistryServices < ActiveRecord::Migration
	def change
		create_table :registry_services do |t|
			t.string :name

			t.timestamps null: false
		end
		RegistryService.create([
			{name: 'Autenticação'},
			{name: 'Reconhecimento de firma'},
			{name: 'Procuração pública'},
			{name: 'Sedex - AR'},
			{name: 'Registro'},
			{name: 'Cartão de assinatura'},
			{name: 'Certidões'},
			{name: 'Arquivamento por folha'},
			{name: 'Outros'}
			])
	end
end
