class ResponsibleRegistrationUnitsGrid

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
    ResponsibleRegistrationUnit.order(:name)
  end

  column(:name, :html => true, :header => "Responsável") do |record|
    render "datagrid_actions_show_responsible_registration_unit", :object => record
  end

  column(:office, :order => "office", :header => "Cargo/Função") do |record|
    record.office
  end

  column(:department, :order => "department", :header => "Departamento") do |record|
    record.department
  end

  column(:whatsapp, :order => "whatsapp", :header => "Whatsapp") do |record|
    record.whatsapp
  end

  column(:skype, :order => "skype", :header => "Skype") do |record|
    record.skype
  end

  column(:email, :order => "email", :header => "Email") do |record|
    record.email_users.pluck(:email).join(', ')
  end

  column(:phone, :order => "phone", :header => "Telefone") do |record|
    record.phone_users.pluck(:phone).join(', ')
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions_responsible_registration_units", :object => record
  end

end
