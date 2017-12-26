class CreateCaptureFormPresencials < ActiveRecord::Migration
	def change
		create_table :capture_form_presencials do |t|
			t.string :name

			t.timestamps null: false
		end
		CaptureFormPresencial.create([
			{name: 'Terceirizado'},
			{name: 'Diligência BRS'}
			])
	end
end
