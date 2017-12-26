class Sector < ActiveRecord::Base
	audited
	
	belongs_to :organ

	has_many :phone_sectors, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_sectors, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_sectors, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_sectors, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	validates_presence_of :name, :responsible_name
	
end
