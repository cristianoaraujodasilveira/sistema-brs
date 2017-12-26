class CreateProcessStatuses < ActiveRecord::Migration
	def change
		create_table :process_statuses do |t|
			t.string :name

			t.timestamps null: false
		end
		ProcessStatus.create([
			{ name: 'Atualizado'},
			{ name: 'Arquivado'},
			{ name: 'Em acompanhamento'}
			])
	end
end
