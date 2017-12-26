class LawyersGrid

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

  filter(:name, :string, :header => "Nome") do |value|
    self.where("name LIKE ?", "%#{value}%")
  end

  filter(:lawyer_type, :enum, :select => proc { LawyerType.all.order(:id).map {|c| [c.name, c.id] }}, :header => Lawyer.human_attribute_name(:lawyer_type)) do |value|
    self.where("lawyer_type_id = ?", value)
  end 

  filter(:city, :enum, :select => proc { City.all.order(:name).map {|c| [c.name, c.id] }}, :header => Lawyer.human_attribute_name(:city)) do |value|
    self.where("city_id = ?", value)
  end 

  filter(:state, :enum, :select => proc { State.all.order(:name).map {|c| [c.acronym, c.id] }}, :header => Lawyer.human_attribute_name(:state)) do |value|
    self.where("state_id = ?", value)
  end 

  scope do
    Lawyer.includes(:lawyer_type).includes(:state).includes(:city).order(:name)
  end
  
  column(:name, :html => true, :order => "name", :header => Lawyer.human_attribute_name(:name)) do |record|
    render "show_lawyer", :object => record
  end

  column(:oab, :order => "oab", :header => "OAB") do |record|
    record.oab
  end

  column(:lawyer_type, :order => "lawyer_types.name", :header => Lawyer.human_attribute_name(:lawyer_type)) do |record|
    if record.lawyer_type
      record.lawyer_type.name
    end
  end

  column(:city, :order => "cities.name", :header => Lawyer.human_attribute_name(:city)) do |record|
    if record.city
      record.city.name
    end
  end

  column(:state, :order => "states.name", :header => Lawyer.human_attribute_name(:state)) do |record|
    if record.state
      record.state.name
    end
  end

  column(:actions, :html => true, :header => Lawyer.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
