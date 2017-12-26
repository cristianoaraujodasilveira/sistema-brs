class CreatePieceHistoricSituations < ActiveRecord::Migration
	def change
		create_table :piece_historic_situations do |t|
			t.references :piece, index: true, foreign_key: true
			t.references :old_piece_situation, index: true, references: :piece_situations
			t.references :new_piece_situation, index: true, references: :piece_situations

			t.timestamps null: false
		end
	end
end
