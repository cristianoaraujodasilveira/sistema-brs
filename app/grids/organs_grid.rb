class OrgansGrid

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
    Organ.order(:name)
  end

  filter(:name, :string, :header => "Nome do orgão") do |value|
    self.where("name LIKE ?", "%#{value}%")
  end  

  filter(:sphere_id, :enum, :select => proc { Sphere.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Esfera") do |value|
    self.where("sphere_id = ?", value)
  end

  filter(:identification_number, :string, :header => "Identificação do orgão") do |value|
    self.where("identification_number LIKE ?", "%#{value}%")
  end  

  column(:id_organ, :order => "id", :header => "N. do Orgão") do |record|
    record.id
  end 
  
  column(:name, :html => true, :header => "Orgão") do |record|
    render "datagrid_actions_show_organ", :object => record
  end

  column(:cnpj_organ, :order => "cnpj", :header => "CNPJ") do |record|
    record.cnpj
  end 

  column(:phone_organ, :order => "phone", :header => "Telefone geral") do |record|
    record.phone
  end

  column(:sphere_organ, :order => "sphere", :header => "Esfera") do |record|
    if record.sphere
      record.sphere.name
    end
  end

  column(:identification_number_organ, :order => "identification_number", :header => "Identificação do orgão") do |record|
    record.identification_number
  end

  column(:sector_organ, :html => true, :header => "Setor") do |record|
    render "datagrid_actions_show_all_sectors", :object => record
  end

  column(:actions_organ, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
