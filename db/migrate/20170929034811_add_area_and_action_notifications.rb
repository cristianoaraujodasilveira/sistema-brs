class AddAreaAndActionNotifications < ActiveRecord::Migration
	def change
		ActionNotification.create([
			{name: 'Cadastro de comunicado interno'},
			{name: 'Edição de comunicado interno'},
			{name: 'Exclusão de comunicado interno'},
			{name: 'Finalização de comunicado interno'},
			{name: 'Reabertura de comunicado interno'},
			])
		AreaNotification.create([
			{name: 'Comunicação Interna'},
			])
	end
end
