class PiecesGrid

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

  filter(:deadline, :date, :range => true, :header => Piece.human_attribute_name(:deadline)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("deadline >= '#{value[0]} 00:00:00' AND deadline <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("deadline >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("deadline <= '#{value[1]} 23:59:59'")
    end
  end

  filter(:initial_date, :date, :range => true, :header => Piece.human_attribute_name(:initial_date)) do |value|
    if value[0] != nil && value[1] != nil
      self.where("initial_date >= '#{value[0]} 00:00:00' AND initial_date <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("initial_date >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("initial_date <= '#{value[1]} 23:59:59'")
    end
  end

  filter(:lawyers, :enum, :select => proc { Lawyer.all.order(:id).map {|c| [c.name, c.id] }}, :header => Piece.human_attribute_name(:lawyer)) do |value|
    self.joins(:lawyers).where("lawyer_id = ?", value)
  end 

  filter(:client, :enum, :select => proc { Client.all.order(:fantasy_name).map {|c| [c.fantasy_name, c.id] }}, :header => Piece.human_attribute_name(:client)) do |value|
    self.where("client_id = ?", value)
  end 

  filter(:organ, :enum, :select => proc { Organ.all.order(:name).map {|c| [c.name, c.id] }}, :header => Piece.human_attribute_name(:organ)) do |value|
    self.where("organ_id = ?", value)
  end 

  filter(:piece_situation, :enum, :select => proc { PieceSituation.all.order(:name).map {|c| [c.name, c.id] }}, :header => Piece.human_attribute_name(:piece_situation)) do |value|
    self.where("piece_situation_id = ?", value)
  end 

  filter(:piece_result, :enum, :select => proc { PieceResult.all.order(:name).map {|c| [c.name, c.id] }}, :header => Piece.human_attribute_name(:piece_result)) do |value|
    self.where("piece_result_id = ?", value)
  end 

  scope do
    Piece.includes(:piece_name).includes(:lawyers).includes(:client).includes(:organ).includes(:piece_situation).includes(:piece_result).includes(:observations).order(piece_situation_id: :asc)
  end

  column(:piece_situation, :html => true, :order => "piece_situations.name", :header => Piece.human_attribute_name(:piece_situation)) do |record|
    render "show_situation", :object => record
  end

  column(:deadline, :html => true, :header => Piece.human_attribute_name(:deadline)) do |record|
    if record.deadline != nil
      render "show_situation_by_client", :object => record, :text => (I18n.l record.deadline.to_datetime, format: :full)
    end
  end

  column(:client, :html => true, :order => "clients.fantasy_name", :header => Piece.human_attribute_name(:client)) do |record|
    if record.client
      render "show_situation_by_client", :object => record, :text => record.client.fantasy_name
    end
  end

  column(:organ, :html => true, :order => "organs.name", :header => Piece.human_attribute_name(:organ)) do |record|
    if record.organ
      render "show_situation_by_client", :object => record, :text => record.organ.name
    end
  end

  column(:piece_name, :html => true, :order => "piece_names.name", :header => Piece.human_attribute_name(:piece_name)) do |record|
    if record.piece_name
      render "show_situation_by_client", :object => record, :text => record.piece_name.name
    end
  end

  column(:modalidate, :order => "modalidates.name", :header => Piece.human_attribute_name(:modalidate)) do |record|
    if record.modalidate
      record.modalidate.name
    end
  end

  column(:number, :order => "number", :header => Piece.human_attribute_name(:number)) do |record|
    record.number
  end

  column(:lawyer, :order => "lawyers.name", :header => Piece.human_attribute_name(:lawyers)) do |record|
    if record.lawyers
      record.lawyers.pluck(:name).join(', ')
    end
  end

  column(:last_launch, :header => 'Último lançamento') do |record|
    if record.observations.length > 0
      I18n.l record.observations.last.created_at.to_datetime, format: :full
    else
      I18n.l record.created_at.to_datetime, format: :full
    end
  end

  # column(:process, :order => "process", :header => Piece.human_attribute_name(:process)) do |record|
  #   record.process
  # end

  # column(:piece_situation, :html => true, :order => "piece_situations.name", :header => Piece.human_attribute_name(:piece_situation)) do |record|
  #   render "show_historic_situation", :object => record
  # end

  column(:piece_result, :order => "piece_results.name", :header => Piece.human_attribute_name(:piece_result)) do |record|
    if record.piece_result
      record.piece_result.name
    end
  end

  column(:actions, :html => true, :header => Piece.human_attribute_name(:actions)) do |record|
    render "datagrid_actions", :object => record
  end

end
