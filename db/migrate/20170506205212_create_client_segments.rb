class CreateClientSegments < ActiveRecord::Migration
  def change
    create_table :client_segments do |t|
      t.string :name
      t.text :products_services
	  t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
