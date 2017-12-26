class BiddingResponsible < ActiveRecord::Base
	audited
	
	belongs_to :bidding
	belongs_to :user
end
