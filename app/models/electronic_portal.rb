class ElectronicPortal < ActiveRecord::Base
	belongs_to :organ

	validates_presence_of :value
end
