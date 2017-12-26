class CreatePermissionProfiles < ActiveRecord::Migration
	def change
		create_table :permission_profiles do |t|
			t.string :name

			t.timestamps null: false
		end
		PermissionProfile.create([
			{name: 'Comercial'},
			{name: 'Licitação'},
			{name: 'Jurídico'},
			{name: 'Financeiro'},
			{name: 'Parceiro'},
			{name: 'Cadastros'},
			{name: 'Relatórios'}
			])
	end
end
