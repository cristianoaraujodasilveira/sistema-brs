class ContabilitySecondaryContact < ActiveRecord::Base
	audited
	
	belongs_to :client_contability
end
