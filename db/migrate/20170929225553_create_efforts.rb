class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|
      t.references :bidding, index: true, foreign_key: true
      t.string :number
      t.string :value
      t.date :signature_date
      t.date :initial_date
      t.date :final_date

      t.timestamps null: false
    end
  end
end
