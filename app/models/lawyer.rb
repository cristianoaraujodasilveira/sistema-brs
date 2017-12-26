class Lawyer < ActiveRecord::Base
	audited
	
	belongs_to :lawyer_type
	belongs_to :honorary_form
	belongs_to :state
	belongs_to :city

	has_many :addresses, :validate => false, :as => :addresstable, dependent: :destroy
	accepts_nested_attributes_for :addresses, allow_destroy: true

	has_many :phones, :as => :phonetable, dependent: :destroy
	accepts_nested_attributes_for :phones, allow_destroy: true, :reject_if => proc { |attrs| attrs[:phone].blank? }

	has_many :emails, :as => :emailtable, dependent: :destroy
	accepts_nested_attributes_for :emails, allow_destroy: true, :reject_if => proc { |attrs| attrs[:email].blank? }

	validates_presence_of :lawyer_type_id, 
	:name,
	:created_date,
	:cpf,
	:oab,
	:state_id,
	:city_id,
	:honorary_value,
	:honorary_form_id

	validate :require_at_least_one_phone, :require_at_least_one_email

	private

	def require_at_least_one_phone
		errors.add(:base,"Deve haver ao menos 1 telefone") if self.phones.blank?
	end

	def require_at_least_one_email
		errors.add(:base,"Deve haver ao menos 1 email") if self.emails.blank?
	end

end
