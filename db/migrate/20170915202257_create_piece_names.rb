class CreatePieceNames < ActiveRecord::Migration
  def change
    create_table :piece_names do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
