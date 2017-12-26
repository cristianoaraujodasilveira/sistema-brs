class ClientSegment < ActiveRecord::Base
	audited
	
	belongs_to :client

	has_many :words_keys, dependent: :destroy
	accepts_nested_attributes_for :words_keys, allow_destroy: true, :reject_if => proc { |attrs| attrs[:word].blank? }

end
