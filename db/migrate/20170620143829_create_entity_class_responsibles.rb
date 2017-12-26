class CreateEntityClassResponsibles < ActiveRecord::Migration
	def change
		create_table :entity_class_responsibles do |t|
			t.references :entity_class, index: true, foreign_key: true
			t.string :name
			t.string :office
			t.string :department
			t.string :whatsapp
			t.string :skype
			
			t.timestamps null: false
		end
	end
end
