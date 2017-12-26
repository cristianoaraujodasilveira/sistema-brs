class Library < ActiveRecord::Base
	audited

	belongs_to :library_category
	belongs_to :state
	belongs_to :city

	has_many :attachments, :as => :attachmentable, dependent: :destroy
	accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => proc { |attrs| attrs[:attachment].blank? }

	has_many :words_keys, dependent: :destroy
	accepts_nested_attributes_for :words_keys, allow_destroy: true, :reject_if => proc { |attrs| attrs[:word].blank? }

	validates_presence_of :library_category_id, :title, :author_name

	scope :find_by_text, lambda { |value| where('title LIKE ? or author_name LIKE ? or edition LIKE ? or publishing_company LIKE ? or document_name lIKE ? or description LIKE ?', "%#{value}%", "%#{value}%", "%#{value}%", "%#{value}%", "%#{value}%", "%#{value}%" ) if value != nil && value != '' }
	scope :find_by_state, lambda { |value| where('state_id = ?', value ) if value != nil && value != '' }
end
