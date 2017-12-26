class PortalsGrid

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
  
  filter(:name, :string, :header => Portal.human_attribute_name(:name)) do |value|
    self.where("name LIKE ?", "%#{value}%")
  end  

  filter(:site, :string, :header => Portal.human_attribute_name(:site)) do |value|
    self.where("site LIKE ?", "%#{value}%")
  end

  filter(:client_id, :enum, :select => proc { Client.all.order('lower(fantasy_name)').map {|c| [c.fantasy_name, c.id] }}, :header => Portal.human_attribute_name(:client)) do |value|
    self.where("client_id = ?", value)
  end 

  scope do
    Portal.order(:name)
  end

  column(:name, :html => true, :order => "name", :header => Portal.human_attribute_name(:name)) do |record|
    render "show_portal", :object => record
  end

  column(:site, :order => "site", :header => Portal.human_attribute_name(:site)) do |record|
    record.site
  end

  column(:client, :header => Portal.human_attribute_name(:client)) do |record|
    if record.client
      record.client.fantasy_name
    end
  end

  column(:responsible, :order => "responsible", :header => Portal.human_attribute_name(:responsible)) do |record|
    record.responsible
  end

  column(:responsible_name, :header => Portal.human_attribute_name(:responsible_name)) do |record|
    if record.responsibles && record.responsibles.length > 0
      record.responsibles[0].name
    end
  end

  column(:responsible_phone, :header => Portal.human_attribute_name(:responsible_phone)) do |record|
    if record.responsibles && record.responsibles.length > 0 && record.responsibles[0].phones.length > 0 
      record.responsibles[0].phones[0].phone
    end
  end

  column(:responsible_email, :header => Portal.human_attribute_name(:responsible_email)) do |record|
    if record.responsibles && record.responsibles.length > 0 && record.responsibles[0].emails.length > 0 
      record.responsibles[0].emails[0].email
    end
  end

  column(:actions, :html => true, :header => Portal.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
