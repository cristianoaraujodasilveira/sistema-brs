class ClientClient < ActiveRecord::Base
	audited
	
	belongs_to :client
	belongs_to :client_children, :class_name => 'Client'
end
