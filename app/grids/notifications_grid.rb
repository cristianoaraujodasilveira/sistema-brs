class NotificationsGrid

  include Datagrid

  Datagrid.configure do |config|

    # Defines date formats that can be used to parse date.
    # Note that multiple formats can be specified but only first format used to format date as string. 
    # Other formats are just used for parsing date from string in case your App uses multiple.
    config.date_formats = ["%d/%m/%Y", "%d-%m-%Y"]

    # Defines timestamp formats that can be used to parse timestamp.
    # Note that multiple formats can be specified but only first format used to format timestamp as string. 
    # Other formats are just used for parsing timestamp from string in case your App uses multiple.
    config.datetime_formats = ["%d/%m/%Y %h:%M", "%d-%m-%Y %h:%M:%s"]
  end

  filter(:created_at, :date, :range => true, :header => Notification.human_attribute_name(:created_at)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("created_at >= '#{value[0]} 00:00:00' AND created_at <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("created_at >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("created_at <= '#{value[1]} 23:59:59'")
    end
  end

  filter(:action_notification_id, :enum, :select => proc { ActionNotification.all.order(:id).map {|c| [c.name, c.id] }}, :header => Notification.human_attribute_name(:action_notification)) do |value|
    self.where("action_notification_id = ?", value)
  end 

  filter(:sender_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Notification.human_attribute_name(:sender)) do |value|
    self.where("sender_id = ?", value)
  end 

  filter(:receiver_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Notification.human_attribute_name(:receiver)) do |value|
    self.where("receiver_id = ?", value)
  end 

  filter(:read, :xboolean, :header => Notification.human_attribute_name(:read)) do |value|
    if value == 'Sim'
      self.read
    else
      self.unread
    end
  end 

  scope do
    Notification.order(created_at: :desc)
  end

  column(:created_at, :header => Notification.human_attribute_name(:created_at)) do |record|
    if record.created_at != nil
      I18n.l record.created_at.to_datetime, format: :full
    end
  end

  column(:action_notification, :html => true, :order => "action_notification_id", :header => Notification.human_attribute_name(:action_notification)) do |record|
    render "show_text_notification", :object => record
  end

  column(:sender, :header => Notification.human_attribute_name(:sender)) do |record|
    if record.sender
      record.sender.name
    end
  end

  column(:receiver, :header => Notification.human_attribute_name(:receiver)) do |record|
    if record.receiver
      record.receiver.name
    end
  end

  column(:read, :html => true, :header => Notification.human_attribute_name(:read)) do |record|
    render "datagrid_actions", :object => record
  end

end
