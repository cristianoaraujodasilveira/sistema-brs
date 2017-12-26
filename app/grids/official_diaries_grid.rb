class OfficialDiariesGrid

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
  
  filter(:name, :string, :header => OfficialDiary.human_attribute_name(:name)) do |value|
    self.where("name LIKE ?", "%#{value}%")
  end  

  filter(:sphere_id, :enum, :select => proc { Sphere.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => OfficialDiary.human_attribute_name(:sphere)) do |value|
    self.where("sphere_id = ?", value)
  end 

  scope do
    OfficialDiary.order(:name)
  end

  column(:name, :html => true, :order => "name", :header => OfficialDiary.human_attribute_name(:name)) do |record|
    render "show_official_diary", :object => record
  end

  column(:site, :order => "site", :header => OfficialDiary.human_attribute_name(:site)) do |record|
    record.site
  end

  column(:sphere, :header => OfficialDiary.human_attribute_name(:sphere)) do |record|
    if record.sphere
      record.sphere.name
    end
  end

  column(:phone_brs, :header => OfficialDiary.human_attribute_name(:phone_brs)) do |record|
    record.phone_brs
  end

  column(:email_brs, :header => OfficialDiary.human_attribute_name(:email_brs)) do |record|
    record.email_brs
  end

  column(:actions, :html => true, :header => OfficialDiary.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
