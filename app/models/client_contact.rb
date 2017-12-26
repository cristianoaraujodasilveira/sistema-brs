class ClientContact < ActiveRecord::Base
	audited

	belongs_to :client
	belongs_to :state
	belongs_to :city
	belongs_to :client_contact_type
	belongs_to :client_class

	has_many :phone_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :phone_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :email_users, :validate => false, dependent: :destroy
	accepts_nested_attributes_for :email_users, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	validates_presence_of :zipcode, :address, :number, :district, :responsible_name, :state_id, :city_id

end
