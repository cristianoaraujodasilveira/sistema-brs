class ClientBank < ActiveRecord::Base
	audited
	
	belongs_to :account_bank_type
	belongs_to :client

	validates_presence_of :owner_account, :bank_name, :bank_code, :agency_number, :agency_name, :account_bank_type_id, :account_number
end
