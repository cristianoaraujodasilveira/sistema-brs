class CreateResponsibles < ActiveRecord::Migration
  def change
    create_table :responsibles do |t|
      t.integer :responsibletable_id, :null => false
      t.string :responsibletable_type, :null => false, :limit => 30 

      t.string :name
      t.string :office
      t.string :department
      t.string :phone
      t.string :email
      t.string :skype
      t.string :whatsapp
      t.integer :type

      t.timestamps null: false
    end
    add_index :responsibles, [:responsibletable_id, :responsibletable_type], :name => 'my_index'
  end
end
