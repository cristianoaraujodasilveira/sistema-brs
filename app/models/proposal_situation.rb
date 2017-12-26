class ProposalSituation < ActiveRecord::Base
	has_many :proposals

	validates_presence_of :name
end
