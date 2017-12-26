class RegistrationUnit < ActiveRecord::Base
	audited
	
	belongs_to :organ
	belongs_to :state
	belongs_to :city
	belongs_to :registration_unit

	has_many :registration_units, dependent: :destroy
	accepts_nested_attributes_for :registration_units, allow_destroy: true

	has_many :responsible_registration_units, dependent: :destroy
	accepts_nested_attributes_for :responsible_registration_units, allow_destroy: true

	has_many :phone_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	validates_presence_of :organ_id, 
	:name,
	:zipcode,
	:address,
	:district,
	:number,
	:state_id,
	:city_id

end
