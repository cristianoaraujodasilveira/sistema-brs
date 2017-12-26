class BiddingProposalsGrid

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
  
  filter(:date_payment_comission, :date, :range => true, :header => Bidding.human_attribute_name(:date)) do |value|
    if value[0] != nil && value[1] != nil
      self.joins(:bidding).where("biddings.date_payment_comission >= '#{value[0]} 00:00:00' AND biddings.date_payment_comission <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.joins(:bidding).where("biddings.date_payment_comission >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.joins(:bidding).where("biddings.date_payment_comission <= '#{value[1]} 23:59:59'")
    end
  end

  filter(:catch_client_id, :enum, :select => proc { Client.all.order('lower(fantasy_name)').map {|c| [c.fantasy_name, c.id] }}, :header => Bidding.human_attribute_name(:catch_client_fantasy_name)) do |value|
    self.joins(:bidding).where("biddings.catch_client_id = ?", value)
  end 

  filter(:organ_id, :enum, :select => proc { Organ.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => Bidding.human_attribute_name(:catch_organ_id)) do |value|
    self.joins(:bidding).where("biddings.catch_organ_id = ?", value)
  end 

  scope do
    BiddingProposal.includes(:bidding).includes(bidding: :catch_organ).includes(bidding: :catch_client).joins(:participation_result).joins(:competition_status).where(:participation_result_id => 1).where(:competition_status_id => [2,3,4]).order('biddings.date_payment_comission ASC')
  end

  column(:circle, :html => true, :header => '') do |record|
    render "show_circle", :object => record
  end

  column(:catch_competition_date, :header => 'Data de vencimento do pagamento') do |record|
    if record.bidding && record.bidding.date_payment_comission
      I18n.l record.bidding.date_payment_comission.to_datetime, format: :default
    end
  end

  column(:catch_client_fantasy_name, :header => Bidding.human_attribute_name(:catch_client_fantasy_name)) do |record|
    if record.bidding && record.bidding.catch_client 
      record.bidding.catch_client.fantasy_name
    end
  end

  column(:catch_organ, :header => Bidding.human_attribute_name(:catch_organ_id)) do |record|
    if record.bidding && record.bidding.catch_organ 
      record.bidding.catch_organ.name
    end
  end

  column(:number, :header => Bidding.human_attribute_name(:catch_number)) do |record|
    if record.bidding  
      record.bidding.catch_number
    end
  end

  column(:ride_in_process, :header => Bidding.human_attribute_name(:ride_in_process)) do |record|
    if record.bidding  
      if record.bidding.ride_in_process
        'Sim'
      else
        'Não'
      end
    end
  end

  column(:number, :header => Bidding.human_attribute_name(:residual_value_contract)) do |record|
    if record.bidding  
      record.bidding.residual_value_contract
    end
  end

  column(:actions, :html => true, :header => Bidding.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
