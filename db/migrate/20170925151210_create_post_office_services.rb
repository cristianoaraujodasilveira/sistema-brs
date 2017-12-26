class CreatePostOfficeServices < ActiveRecord::Migration
	def change
		create_table :post_office_services do |t|
			t.string :name

			t.timestamps null: false
		end
		PostOfficeService.create([
			{name: 'Coleta'},
			{name: 'Entrega'},
			{name: 'PAC - AR'},
			{name: 'Sedex - AR'},
			{name: 'Sedex 10 - AR'},
			{name: 'Sedex 12 - AR'},
			{name: 'Simples - AR'},
			{name: 'Especial - AR'},
			{name: 'Outros'}
			])
	end
end
