class CreatePieceResults < ActiveRecord::Migration
  def change
    create_table :piece_results do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
