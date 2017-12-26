class Email < ActiveRecord::Base
	audited
	
	belongs_to :emailtable, :polymorphic => true
end
