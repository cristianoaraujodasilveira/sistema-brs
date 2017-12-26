class EmailUser < ActiveRecord::Base
	audited
	
	belongs_to :user
	validates_presence_of :email, :user_id
	validates_email_format_of :email, :message => 'inválido'
	
end
