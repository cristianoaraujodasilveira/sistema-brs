class ContractPayment < ActiveRecord::Base
	audited
	
	belongs_to :contract
	belongs_to :payment_form
	belongs_to :payment_from
	belongs_to :payment_sugestion_day
	has_and_belongs_to_many :payment_scopes
	
	validates_presence_of :payment_form_id, :payment_from_id
end
