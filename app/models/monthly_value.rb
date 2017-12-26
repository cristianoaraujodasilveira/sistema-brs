class MonthlyValue < ActiveRecord::Base
	audited
	
	belongs_to :proposal
end
