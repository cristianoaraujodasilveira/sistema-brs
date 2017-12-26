class AuditsGrid

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

  filter(:user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Usuário") do |value|
    self.where("user_id = ?", value)
  end 

  filter(:auditable_type, :enum, :select => proc { Audit.group(:auditable_type).order('lower(auditable_type)').map {|c| [c.get_name_type, c.auditable_type] }}, :header => "Área") do |value|
    self.where("auditable_type = ?", value)
  end 

  filter(:created_at, :date, :range => true, :default => proc { [Time.now.beginning_of_month, Time.now.end_of_month]}, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("created_at >= '#{value[0]} 00:00:00' AND created_at <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("created_at >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("created_at <= '#{value[1]} 23:59:59'")
    end
  end
  
  scope do
    Audit.order(created_at: :desc).where.not(:comment => nil).where.not(:user_id => 1)
  end

  column(:user, :header => "Usuário") do |record|
    if record.user_id != nil
      user = User.where(:id => record.user_id).first
      if user
        user.name
      end
    end
  end

  column(:auditable_type, :header => "Área do sistema") do |record|
    record.get_name_type
  end

  column(:action, :header => "Ação realizada") do |record|
    record.comment
  end
  
  column(:created_at, :header => "Data e hora") do |record|
    if record.created_at != nil
      zone = ActiveSupport::TimeZone.new("Brasilia")
      I18n.l record.created_at.to_datetime.in_time_zone(zone), format: :full
    end
  end

end
