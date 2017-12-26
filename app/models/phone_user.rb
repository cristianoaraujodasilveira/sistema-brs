class PhoneUser < ActiveRecord::Base
	audited
	
	belongs_to :user
	validates_presence_of :phone, :user_id
end
