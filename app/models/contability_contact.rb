class ContabilityContact < ActiveRecord::Base
	audited
	
	belongs_to :client_contability
end
