class VisitsReportsGrid

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

  filter(:fantasy_name, :string, :header => "Nome fantasia") do |value|
    self.where("fantasy_name LIKE ?", "%#{value}%")
  end

  filter(:social_name, :string, :header => "Razão Social") do |value|
    self.where("social_name LIKE ?", "%#{value}%")
  end

  filter(:proposal_text, :string, :header => "Título da proposta") do |value|
    self.where("proposal_text LIKE ?", "%#{value}%")
  end

  filter(:user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Intermediador") do |value|
    self.where("user_id = ?", value)
  end 

  filter(:date_and_time, :date, :range => true, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("visits_reports.date_and_time >= '#{value[0]} 00:00:00' AND visits_reports.date_and_time <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("visits_reports.date_and_time >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("visits_reports.date_and_time <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    VisitsReport.includes(:user).order('lower(fantasy_name)')
  end

  column(:id, :order => "id", :header => "Nº da visita") do |record|
    record.id
  end  

  column(:fantasy_name, :html => true, :order => "fantasy_name", :header => "Nome fantasia") do |record|
    render "show_visit", :object => record, :type => 1
  end

  column(:social_name, :html => true, :order => "social_name", :header => "Razão social") do |record|
    render "show_visit", :object => record, :type => 2
  end

  column(:client_cnpj, :order => "cnpj", :header => "CNPJ") do |record|
    record.cnpj
  end

  column(:responsible_name, :order => "responsible_name", :header => "Contato responsável") do |record|
    record.responsible_name
  end

  column(:proposal_text, :order => "proposal_text", :header => "Título da proposta") do |record|
    record.proposal_text
  end
  
  column(:user, :order => "users.name", :header => "Intermediador") do |record|
    if record.user
      record.user.name
    end
  end

  column(:date_and_time, :header => "Data") do |record|
    if record.date_and_time != nil
      I18n.l record.date_and_time.to_datetime, format: :full
    end
  end

  column(:subject, :order => "subject", :header => "Assunto") do |record|
    record.subject
  end


  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
