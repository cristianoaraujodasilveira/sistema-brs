class CreateClientContabilities < ActiveRecord::Migration
  def change
    create_table :client_contabilities do |t|
      t.string :name
      t.string :zipcode
      t.string :address
      t.string :district
      t.string :number
      t.string :complement
      t.references :client, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.boolean :extern_contability
      t.boolean :intern_contability

      t.timestamps null: false
    end
  end
end
