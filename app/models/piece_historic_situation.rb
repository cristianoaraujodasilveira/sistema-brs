class PieceHistoricSituation < ActiveRecord::Base
	belongs_to :piece
	belongs_to :user
	belongs_to :observation
	belongs_to :old_piece_situation, :class_name => 'PieceSituation'
	belongs_to :new_piece_situation, :class_name => 'PieceSituation'

	validates_presence_of :user_id, :piece_id, :old_piece_situation_id, :new_piece_situation_id
end
