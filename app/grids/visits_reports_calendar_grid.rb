class VisitsReportsCalendarGrid

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

  filter(:name, :string, :header => "Razão Social") do |value|
    self.joins(:user).where("proposal_text LIKE ? or fantasy_name LIKE ? or social_name LIKE ? or users.name LIKE ?", "%#{value}%", "%#{value}%", "%#{value}%", "%#{value}%")
  end

  filter(:initial_date, :date, :range => true, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("visits_reports.date_and_time >= '#{value[0]} 00:00:00' AND visits_reports.date_and_time <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("visits_reports.date_and_time >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("visits_reports.date_and_time <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    VisitsReport.includes(:user).order(:id)
  end

  column(:fantasy_name, :order => "fantasy_name", :header => "Nome fantasia") do |record|
    record.fantasy_name
  end

  column(:responsible_name, :order => "responsible_name", :header => "Contato responsável") do |record|
    record.responsible_name
  end

  column(:date_and_time, :header => "Data") do |record|
    if record.date_and_time != nil
      I18n.l record.date_and_time.to_datetime, format: :full
    end
  end

  column(:subject, :order => "subject", :header => "Assunto") do |record|
    record.subject
  end

end
