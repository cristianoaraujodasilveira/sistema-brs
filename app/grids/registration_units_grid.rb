class RegistrationUnitsGrid

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
    RegistrationUnit.includes(:organ).includes(:email_users).includes(:phone_users).order(:name)
  end

  filter(:organ_id, :enum, :select => proc { Organ.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Orgão") do |value|
    self.where("organ_id = ?", value)
  end

  filter(:name, :string, :header => "Nome da Unidade") do |value|
    self.where("name LIKE ?", "%#{value}%")
  end
  
  column(:name, :html => true, :header => "Nome da unidade") do |record|
    render "datagrid_action_show_registration_unit", :object => record
  end

  column(:organ, :order => "organ.name", :header => "Orgão") do |record|
    if record.organ
      record.organ.name
    end
  end

  column(:site, :order => "site", :header => "Site") do |record|
    record.site
  end

  column(:email, :order => "email", :header => "Email") do |record|
    record.email_users.pluck(:email).join(', ')
  end

  column(:phone, :order => "phone", :header => "Telefone") do |record|
    record.phone_users.pluck(:phone).join(', ')
  end

  column(:sector, :html => true, :header => "Responsável") do |record|
    render "datagrid_actions_show_all_responsible_registration_units", :object => record
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
