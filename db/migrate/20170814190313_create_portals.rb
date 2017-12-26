class CreatePortals < ActiveRecord::Migration
  def change
    create_table :portals do |t|

      t.references :user, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true

      t.string :name
      t.date :initial_date
      t.date :final_date
      t.string :site
      t.string :phone
      t.string :email
      t.string :responsible
      t.string :registration_unit

      t.timestamps null: false
    end
  end
end
