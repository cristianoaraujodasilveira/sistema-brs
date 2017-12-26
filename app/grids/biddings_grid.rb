class BiddingsGrid

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

  filter(:id, :string, :header => Bidding.human_attribute_name(:id)) do |value|
    self.where("id = ?", value)
  end  

  filter(:catch_organ_id, :enum, :select => proc { Organ.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:catch_organ)) do |value|
    self.where("catch_organ_id = ?", value)
  end 

  filter(:catch_portal_id, :enum, :select => proc { Portal.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:catch_portal)) do |value|
    self.where("catch_portal_id = ?", value)
  end 

  filter(:catch_user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:catch_user)) do |value|
    self.where("catch_user_id = ?", value)
  end 

  filter(:read_user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:read_user)) do |value|
    self.where("read_user_id = ?", value)
  end 

  filter(:participation_users, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:participation_users)) do |value|
    self.joins(:participation_users).where(biddings_users: { user_id: value })
  end 

  filter(:catch_client_id, :enum, :select => proc { Client.all.order('lower(fantasy_name)').map {|c| [c.fantasy_name, c.id] }}, :header => Bidding.human_attribute_name(:catch_client_fantasy_name)) do |value|
    self.where("catch_client_id = ?", value)
  end 

  filter(:catch_client_social_name_id, :enum, :select => proc { Client.all.order('lower(social_name)').map {|c| [c.social_name, c.id] }}, :header => Bidding.human_attribute_name(:catch_client_social_name)) do |value|
    self.where("catch_client_social_name_id = ?", value)
  end 
  
  filter(:catch_competition_date, :date, :range => true, :header => Bidding.human_attribute_name(:catch_competition_date)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("catch_competition_date >= '#{value[0]} 00:00:00' AND catch_competition_date <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("catch_competition_date >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("catch_competition_date <= '#{value[1]} 23:59:59'")
    end
  end
  
  filter(:catch_date_catch, :date, :range => true, :header => Bidding.human_attribute_name(:catch_date_catch)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("catch_date_catch >= '#{value[0]} 00:00:00' AND catch_date_catch <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("catch_date_catch >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("catch_date_catch <= '#{value[1]} 23:59:59'")
    end
  end
  
  filter(:read_date_read, :date, :range => true, :header => Bidding.human_attribute_name(:read_date_read)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("read_date_read >= '#{value[0]} 00:00:00' AND read_date_read <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("read_date_read >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("read_date_read <= '#{value[1]} 23:59:59'")
    end
  end
  
  filter(:participation_process_status_date, :date, :range => true, :header => Bidding.human_attribute_name(:participation_process_status_date)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("participation_process_status_date >= '#{value[0]} 00:00:00' AND participation_process_status_date <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("participation_process_status_date >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("participation_process_status_date <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    Bidding.includes(:catch_client).includes(:catch_modalidate).includes(:catch_portal).order(:catch_competition_date)
  end

  column(:id, :header => Bidding.human_attribute_name(:id)) do |record|
    record.id
  end

  column(:catch_competition_date, :header => Bidding.human_attribute_name(:catch_competition_date)) do |record|
    if record.catch_competition_date != nil
      I18n.l record.catch_competition_date.to_datetime, format: :full
    end
  end

  column(:catch_limit_date, :header => Bidding.human_attribute_name(:catch_limit_date)) do |record|
    if record.catch_limit_date != nil
      I18n.l record.catch_limit_date.to_datetime, format: :full
    end
  end

  column(:participation_return_date, :header => Bidding.human_attribute_name(:participation_return_date)) do |record|
    if record.participation_return_date != nil
      I18n.l record.participation_return_date.to_datetime, format: :full
    end
  end

  column(:catch_client_fantasy_name, :html => true, :header => Bidding.human_attribute_name(:catch_client_fantasy_name)) do |record|
    render "show_bidding", :object => record, :type => 1
  end

  column(:catch_client_social_name, :html => true, :header => Bidding.human_attribute_name(:catch_client_social_name)) do |record|
    render "show_bidding", :object => record, :type => 2
  end

  column(:catch_organ, :header => Bidding.human_attribute_name(:catch_organ)) do |record|
    if record.catch_organ
      record.catch_organ.name
    end
  end

  column(:catch_modalidate, :header => Bidding.human_attribute_name(:catch_modalidate)) do |record|
    if record.catch_modalidate
      record.catch_modalidate.name
    end
  end

  column(:catch_number, :header => Bidding.human_attribute_name(:catch_number)) do |record|
    record.catch_number
  end

  column(:catch_portal, :header => Bidding.human_attribute_name(:catch_portal)) do |record|
    if record.catch_portal
      record.catch_portal.name
    end
  end

  column(:actions, :html => true, :header => Bidding.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
