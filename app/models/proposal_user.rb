class ProposalsUser < ActiveRecord::Base
	validates_presence_of :user_id, :proposal_id
end
