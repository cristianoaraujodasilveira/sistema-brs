class CreateDiligentServices < ActiveRecord::Migration
	def change
		create_table :diligent_services do |t|
			t.string :name

			t.timestamps null: false
		end
		DiligentService.create([
			{name: 'Entrega'},
			{name: 'Coleta'},
			{name: 'Diligência'},
			{name: 'Outros'}
			])
	end
end
