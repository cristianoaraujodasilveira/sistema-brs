class ClientPeriodicity < ActiveRecord::Base
	has_many :clients

	validates_presence_of :name
end
