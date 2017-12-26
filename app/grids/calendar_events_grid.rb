class CalendarEventsGrid

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

  filter(:name, :string, :header => "Filtro geral (Título, usuário, observação)") do |value|
    self.joins(:user).where("calendar_events.name LIKE ? or observation LIKE ? or users.name LIKE ?", "%#{value}%", "%#{value}%", "%#{value}%")
  end

  filter(:initial_date, :date, :range => true, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("initial_date >= '#{value[0]} 00:00:00' AND initial_date <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("initial_date >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("initial_date <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    CalendarEvent.includes(:user).order(:name)
  end

  column(:document, :html => true, :header => "Título") do |record|
    render "edit_calendar_event", :object => record
  end

  column(:user, :order => "users.name", :header => "Usuário") do |record|
    if record.user
      record.user.name
    end
  end

  column(:initial_date, :header => "Data") do |record|
    if record.initial_date
      I18n.l(record.initial_date.to_date, format: :default)
    end
  end

end
