class Notification < ActiveRecord::Base
	acts_as_readable :on => :created_at

	belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
	belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id"
	
	belongs_to :action_notification
	belongs_to :area_notification

	validates_presence_of :text, :action_notification_id, :area_notification_id

	def as_json(options = {})
		{
			:id => self.id,
			:text => self.text,
			:date => (I18n.l self.created_at.to_datetime, format: :full),
			:name_sender => self.sender.name,
			:name_receiver => self.receiver.name,
			:unread => self.unread?(self.receiver)
		}
	end
end
