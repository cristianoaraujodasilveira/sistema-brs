class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addresstable_id, :null => false
      t.string :addresstable_type, :null => false, :limit => 30 

      t.string :zipcode
      t.string :address
      t.string :district
      t.string :number
      t.string :complement
      t.integer :type

      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :addresses, [:addresstable_id, :addresstable_type], :name => 'my_index'
  end
end
