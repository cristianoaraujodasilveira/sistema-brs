class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.references :piece_name, index: true, foreign_key: true
      t.references :judicial_type, index: true, foreign_key: true
      t.datetime :initial_date
      t.datetime :deadline
      t.references :piece_result, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.references :organ, index: true, foreign_key: true
      t.string :number
      t.string :process
      t.string :protocol_number
      t.references :shipping_type, index: true, foreign_key: true
      t.references :piece_situation, index: true, foreign_key: true
      t.references :modalidate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
