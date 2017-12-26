class CreateCaptureForms < ActiveRecord::Migration
	def change
		create_table :capture_forms do |t|
			t.string :name

			t.timestamps null: false
		end
		CaptureForm.create([
			{name: 'Presencial'},
			{name: 'Eletrônica'},
			{name: 'Jornal de Licitação'},
			{name: 'Enviado pelo parceiro'},
			{name: 'Convidado'},
			{name: 'Solicitação no órgão'},
			{name: 'Outro'}
			])
	end
end
