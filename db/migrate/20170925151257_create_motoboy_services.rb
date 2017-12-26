class CreateMotoboyServices < ActiveRecord::Migration
	def change
		create_table :motoboy_services do |t|
			t.string :name

			t.timestamps null: false
		end
		MotoboyService.create([
			{name: 'Entrega'},
			{name: 'Coleta'},
			{name: 'Diligência'},
			{name: 'Outros'}
			])
	end
end
