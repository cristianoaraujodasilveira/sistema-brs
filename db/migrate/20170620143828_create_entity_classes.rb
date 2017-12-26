class CreateEntityClasses < ActiveRecord::Migration
  def change
    create_table :entity_classes do |t|
      t.string :name
      t.text :description
      t.string :zipcode
      t.string :address
      t.string :number
      t.string :complement
      t.string :district
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
