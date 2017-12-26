class EntityClassesGrid

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

  filter(:name, :string, :header => "Nome da entidade") do |value|
    self.where("name LIKE ?", "%#{value}%")
  end
  
  scope do
    EntityClass.includes(:entity_class_responsibles).order(:name)
  end
  
  column(:name, :html => true,:order => "name", :header => "Nome da entidade") do |record|
    render "show_entity_class", :object => record, :type => 1
  end

  column(:description, :html => true, :order => "description", :header => "Descritivo") do |record|
    render "show_entity_class", :object => record, :type => 2
  end

  column(:address, :order => "address", :header => "Endereço") do |record|
    record.get_complete_address
  end

  column(:responsibles, :order => "responsibles", :header => "Responsável") do |record|
    record.get_responsibles
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
