class ProposalHistoric < ActiveRecord::Base
	audited

	belongs_to :proposal
	belongs_to :user

	validates_presence_of :comment

end
