class BidNewspapersGrid

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
  
  filter(:name, :string, :header => BidNewspaper.human_attribute_name(:name)) do |value|
    self.where("name LIKE ?", "%#{value}%")
  end  

  filter(:site, :string, :header => BidNewspaper.human_attribute_name(:site)) do |value|
    self.where("site LIKE ?", "%#{value}%")
  end

  filter(:client_id, :enum, :select => proc { Client.all.order('lower(fantasy_name)').map {|c| [c.fantasy_name, c.id] }}, :header => BidNewspaper.human_attribute_name(:client)) do |value|
    self.where("client_id = ?", value)
  end 

  scope do
    BidNewspaper.order(:name)
  end

  column(:name, :html => true, :order => "name", :header => BidNewspaper.human_attribute_name(:name)) do |record|
    render "show_bid_newspaper", :object => record
  end

  column(:site, :order => "site", :header => BidNewspaper.human_attribute_name(:site)) do |record|
    record.site
  end

  column(:client, :header => BidNewspaper.human_attribute_name(:client)) do |record|
    if record.client
      record.client.fantasy_name
    end
  end

  column(:responsible_name, :header => BidNewspaper.human_attribute_name(:responsible_name)) do |record|
    if record.responsibles && record.responsibles.length > 0
      record.responsibles[0].name
    end
  end

  column(:phone_brs, :header => BidNewspaper.human_attribute_name(:phone_brs)) do |record|
    record.phone_brs
  end

  column(:email_brs, :header => BidNewspaper.human_attribute_name(:email_brs)) do |record|
    record.email_brs
  end
  
  column(:initial_date, :header => BidNewspaper.human_attribute_name(:initial_date)) do |record|
    if record.initial_date != nil
      I18n.l record.initial_date.to_datetime, format: :full
    end
  end
  
  column(:final_date, :header => BidNewspaper.human_attribute_name(:final_date)) do |record|
    if record.final_date != nil
      I18n.l record.final_date.to_datetime, format: :full
    end
  end

  column(:actions, :html => true, :header => BidNewspaper.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
