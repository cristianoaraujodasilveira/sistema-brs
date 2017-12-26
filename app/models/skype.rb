class Skype < ActiveRecord::Base
	audited
	
	belongs_to :skypetable, :polymorphic => true
end
