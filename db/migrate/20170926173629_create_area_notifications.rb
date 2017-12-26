class CreateAreaNotifications < ActiveRecord::Migration
	def change
		create_table :area_notifications do |t|
			t.string :name

			t.timestamps null: false
		end
		AreaNotification.create([
			{id: 1, name: 'Usuários'},
			{id: 2, name: 'Comercial'},
			{id: 3, name: 'Licitação'},
			{id: 4, name: 'Jurídico'},
			{id: 5, name: 'Financeiro'},
			{id: 6, name: 'Parceiro'},
			{id: 7, name: 'Cadastros'},
			{id: 8, name: 'Relatórios'}
			])
	end
end
