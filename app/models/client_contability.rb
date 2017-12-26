class ClientContability < ActiveRecord::Base
	audited

	belongs_to :client
	belongs_to :state
	belongs_to :city

	has_many :phone_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	has_many :contability_contacts, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :contability_contacts, allow_destroy: true, :reject_if => proc { |attrs| attrs[:name].blank? }

	has_many :contability_secondary_contacts, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :contability_secondary_contacts, allow_destroy: true, :reject_if => proc { |attrs| attrs[:name].blank? }
end
