class Piece < ActiveRecord::Base
	audited
	
	attr_accessor :piece_process_file_id, :folder_name, :file_to_add

	belongs_to :piece_name
	belongs_to :judicial_type
	belongs_to :piece_result
	belongs_to :client
	belongs_to :organ
	belongs_to :shipping_type
	belongs_to :piece_situation
	belongs_to :modalidate

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :observations, :as => :observationtable, dependent: :destroy
	accepts_nested_attributes_for :observations, allow_destroy: true, :reject_if => proc { |attrs| attrs[:observation].blank? }

	has_many :piece_process_files, dependent: :destroy
	accepts_nested_attributes_for :piece_process_files, allow_destroy: true
	
	has_many :piece_historic_situations, dependent: :destroy
	
	has_and_belongs_to_many :lawyers

	validates_presence_of :piece_name_id,
	:judicial_type_id,
	:client_id,
	:organ_id,
	:shipping_type_id,
	:piece_situation_id,
	:number,
	:process,
	:modalidate_id,
	:initial_date,
	:deadline

	validate :require_at_least_one_lawyer

	private

	def require_at_least_one_lawyer
		errors.add(:base,"Deve haver ao menos 1 advogado") if self.lawyers.blank?
	end
	
end
