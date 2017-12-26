class CommunicationsGrid

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

  filter(:user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Communication.human_attribute_name(:user)) do |value|
    self.where("user_id = ?", value)
  end 

  filter(:communications_users, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Communication.human_attribute_name(:users)) do |value|
    self.joins(:communications_users).joins(:communications_users).where(communications_users: { user_id: value })
  end 

  filter(:communication_status_id, :enum, :select => proc { CommunicationStatus.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => Communication.human_attribute_name(:communication_status)) do |value|
    self.where("communication_status_id = ?", value)
  end 
  
  filter(:created_at, :date, :range => true, :header => Communication.human_attribute_name(:created_at)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("created_at >= '#{value[0]} 00:00:00' AND created_at <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("created_at >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("created_at <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    Communication.order(created_at: :desc)
  end

  column(:id, :order => "id", :header => 'ID') do |record|
    record.id
  end

  column(:last_update, :header => Communication.human_attribute_name(:last_update)) do |record|
    if record.observations.length > 0
      I18n.l record.observations.last.created_at.to_datetime, format: :full
    else
      I18n.l record.created_at.to_datetime, format: :full
    end
  end

  column(:created_at, :header => Communication.human_attribute_name(:created_at)) do |record|
    if record.created_at != nil
      I18n.l record.created_at.to_datetime, format: :full
    end
  end

  column(:subject, :html => true, :order => "subject", :header => Communication.human_attribute_name(:subject)) do |record|
    render "show_communication", :object => record
  end

  column(:communication_status, :header => Communication.human_attribute_name(:communication_status)) do |record|
    if record.communication_status
      record.communication_status.name
    end
  end

  column(:user, :header => Communication.human_attribute_name(:user)) do |record|
    if record.user
      record.user.name
    end
  end

  column(:user, :header => Communication.human_attribute_name(:users)) do |record|
    if record.communications_users
      record.communications_users.pluck(:name).join(', ')
    end
  end

  column(:actions, :html => true, :header => Communication.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
