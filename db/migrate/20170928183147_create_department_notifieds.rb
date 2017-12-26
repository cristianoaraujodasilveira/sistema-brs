class CreateDepartmentNotifieds < ActiveRecord::Migration
	def change
		create_table :department_notifieds do |t|
			t.string :name

			t.timestamps null: false
		end
		DepartmentNotified.create([
			{name: 'Comercial'},
			{name: 'Licitação'},
			{name: 'Jurídico'},
			{name: 'Financeiro'},
			{name: 'Parceiro'},
			{name: 'Recepção'}
			])
	end
end
