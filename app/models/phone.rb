class Phone < ActiveRecord::Base
	audited
	
	belongs_to :phonetable, :polymorphic => true
end
