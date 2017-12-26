class CreateActionNotifications < ActiveRecord::Migration
	def change
		create_table :action_notifications do |t|
			t.string :name

			t.timestamps null: false
		end
		ActionNotification.create([
			{id: 1, name: 'Cadastro de usuário'},
			{id: 2, name: 'Edição de usuário'},
			{id: 3, name: 'Exclusão de usuário'},
			{id: 4, name: 'Cadastro de Relatório de visita'},
			{id: 5, name: 'Edição de Relatório de visita'},
			{id: 6, name: 'Exclusão de Relatório de visita'},
			{id: 7, name: 'Cadastro de Proposta'},
			{id: 8, name: 'Edição de Proposta'},
			{id: 9, name: 'Exclusão de Proposta'},
			{id: 10, name: 'Cadastro de Contrato'},
			{id: 11, name: 'Edição de Contrato'},
			{id: 12, name: 'Exclusão de Contrato'},
			{id: 13, name: 'Cadastro de Entidade de Classe'},
			{id: 14, name: 'Edição de Entidade de Classe'},
			{id: 15, name: 'Exclusão de Entidade de Classe'}
			])
	end
end
