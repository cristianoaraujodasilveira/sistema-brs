class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :name
      t.string :office
      t.text :observation
      t.string :responsible_name
      t.references :organ, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
