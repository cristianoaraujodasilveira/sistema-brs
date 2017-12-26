class PieceProcessFile < ActiveRecord::Base
	belongs_to :piece
	
	validates_presence_of :folder_name

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }
end
