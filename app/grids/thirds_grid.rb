class ThirdsGrid

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
  
  filter(:register_number, :string, :header => Third.human_attribute_name(:register_number)) do |value|
    self.where("register_number LIKE ?", "%#{value}%")
  end  
  
  filter(:name, :string, :header => Third.human_attribute_name(:name)) do |value|
    self.where("name LIKE ?", "%#{value}%")
  end  
  
  filter(:fantasy_name, :string, :header => Third.human_attribute_name(:fantasy_name)) do |value|
    self.where("fantasy_name LIKE ?", "%#{value}%")
  end  

  filter(:social_name, :string, :header => Third.human_attribute_name(:social_name)) do |value|
    self.where("social_name LIKE ?", "%#{value}%")
  end

  filter(:state_id, :enum, :select => proc { State.all.order(:acronym).map {|c| [c.acronym, c.id] }}, :header => Address.human_attribute_name(:state)) do |value|
    self.joins(:address).where("state_id = ?", value)
  end 

  filter(:city_id, :enum, :select => proc { City.all.order(:name).map {|c| [c.name, c.id] }}, :header => Address.human_attribute_name(:city)) do |value|
    self.joins(:address).where("city_id = ?", value)
  end 

  scope do
    Third.order('cast(register_number as unsigned) asc')
  end

  column(:register_number, :html => true, :order => "register_number", :header => Third.human_attribute_name(:register_number)) do |record|
    render "show_third", :object => record
  end

  column(:name, :order => "name", :header => Third.human_attribute_name(:name)) do |record|
    if record.name && record.name.length > 0
      record.name
    else
      if record.responsible && record.responsible.name
        record.responsible.name
      end
    end
  end

  column(:fantasy_name, :order => "fantasy_name", :header => Third.human_attribute_name(:fantasy_name)) do |record|
    record.fantasy_name
  end

  column(:social_name, :order => "social_name", :header => Third.human_attribute_name(:social_name)) do |record|
    record.social_name
  end

  column(:state, :header => Address.human_attribute_name(:state)) do |record|
    if record.address && record.address.state
      record.address.state.name
    end
  end

  column(:city, :header => Address.human_attribute_name(:city)) do |record|
    if record.address && record.address.city
      record.address.city.name
    end
  end

  column(:phones, :header => Third.human_attribute_name(:phones)) do |record|
    if record.phones
      record.phones.pluck(:phone).join(', ')
    end
  end

  column(:emails, :header => Third.human_attribute_name(:emails)) do |record|
    if record.emails
      record.emails.pluck(:email).join(', ')
    end
  end

  column(:actions, :html => true, :header => Third.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
