class CreatePieceSituations < ActiveRecord::Migration
  def change
    create_table :piece_situations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
