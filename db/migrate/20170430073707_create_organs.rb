class CreateOrgans < ActiveRecord::Migration
  def change
    create_table :organs do |t|
      t.string :name
      t.string :cnpj
      t.string :site
      t.string :email
      t.string :phone
      t.string :eletronic_portal
      t.string :address
      t.string :zipcode
      t.string :district
      t.string :number
      t.string :complement
      t.string :identification_number
      t.text :observation
      
      t.references :city, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :sphere, index: true, foreign_key: true
      t.references :organ, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
