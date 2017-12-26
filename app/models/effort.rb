class Effort < ActiveRecord::Base
	audited
	belongs_to :bidding
end
