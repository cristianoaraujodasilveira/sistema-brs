class ContractResponsibleFinancial < ActiveRecord::Base
	audited
	
	belongs_to :contract

	validates_presence_of :name

	has_many :phone_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }
end
