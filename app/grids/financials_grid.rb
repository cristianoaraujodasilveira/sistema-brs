class FinancialsGrid

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

  filter(:client, :enum, :select => proc { Client.all.order(:fantasy_name).map {|c| [c.fantasy_name, c.id] }}, :header => Client.human_attribute_name(:fantasy_name)) do |value|
    self.where("client_id = ?", value)
  end 

  filter(:client, :enum, :select => proc { Client.all.order(:social_name).map {|c| [c.social_name, c.id] }}, :header => Client.human_attribute_name(:social_name)) do |value|
    self.where("client_id = ?", value)
  end 

  scope do
    Financial.includes(:client).includes(client: :proposal).includes(client: { proposal: :visits_report }).order('clients.fantasy_name')
  end
  
  column(:client, :html => true, :order => "client", :header => Client.human_attribute_name(:fantasy_name)) do |record|
    if record.client
      render "show_financial", :object => record, :text => record.client.fantasy_name
    end
  end
  
  column(:client, :html => true, :order => "client", :header => Client.human_attribute_name(:social_name)) do |record|
    if record.client
      render "show_financial", :object => record, :text => record.client.social_name
    end
  end

  column(:actions, :html => true, :header => Financial.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
