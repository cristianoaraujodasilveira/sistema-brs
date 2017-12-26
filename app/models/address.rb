class Address < ActiveRecord::Base
	belongs_to :addresstable, :polymorphic => true
	belongs_to :state
	belongs_to :city

	validates_presence_of :zipcode, :address, :district, :number, :state_id, :city_id

end
