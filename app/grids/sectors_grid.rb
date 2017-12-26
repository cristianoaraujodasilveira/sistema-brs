class SectorsGrid

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

  scope do
    Sector.order(:name)
  end

  column(:name, :html => true, :header => "Nome do setor") do |record|
    render "datagrid_actions_show_sector", :object => record
  end

  column(:responsible_name, :order => "responsible_name", :header => "Responsável") do |record|
    record.responsible_name
  end

  column(:office, :order => "office", :header => "Cargo") do |record|
    record.office
  end

  column(:email, :order => "email", :header => "Email") do |record|
    record.email_sectors.pluck(:email).join(', ')
  end

  column(:phone, :order => "phone", :header => "Telefone") do |record|
    record.phone_sectors.pluck(:phone).join(', ')
  end

  column(:observations, :order => "observations", :header => "Observações Gerais") do |record|
    record.observation
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions_sectors", :object => record
  end

end
