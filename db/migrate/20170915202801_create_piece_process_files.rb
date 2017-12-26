class CreatePieceProcessFiles < ActiveRecord::Migration
  def change
    create_table :piece_process_files do |t|
      t.string :folder_name

      t.timestamps null: false
    end
  end
end
