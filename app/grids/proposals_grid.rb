class ProposalsGrid

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
  
  filter(:fantasy_name, :string, :header => "Nome fantasia") do |value|
    self.where("fantasy_name LIKE ?", "%#{value}%")
  end  

  filter(:social_name, :string, :header => "Razão social") do |value|
    self.where("social_name LIKE ?", "%#{value}%")
  end

  filter(:user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Intermediador") do |value|
    self.where("user_id = ?", value)
  end

  filter(:proposal_situation_id, :enum, :select => proc { ProposalSituation.all.order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Situação") do |value|
    self.where("proposal_situation_id = ?", value)
  end 

  filter(:created_at, :date, :range => true, :default => proc { [Time.now.beginning_of_month, Time.now.end_of_month]}, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("proposals.created_at >= '#{value[0]} 00:00:00' AND proposals.created_at <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("proposals.created_at >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("proposals.created_at <= '#{value[1]} 23:59:59'")
    end
  end

  scope do
    Proposal.includes(:client).includes(:proposal_situation).includes(:users).includes(:visits_report).order(:fantasy_name)
  end

  column(:visits_report, :html => true, :header => "ID Relatório de Visita") do |record|
    render "show_visits_report", :object => record.visits_report
  end

  column(:fantasy_name, :html => true, :order => "fantasy_name", :header => "Nome fantasia") do |record|
    render "show_proposal", :object => record, :type => 1
  end

  column(:social_name, :html => true, :order => "social_name", :header => "Razão social") do |record|
    render "show_proposal", :object => record, :type => 2
  end

  # column(:client_cnpj, :order => "clients.cnpj", :header => "CNPJ") do |record|
  #   if record.client
  #     record.client.cnpj
  #   end
  # end

  column(:client_cnpj, :order => "cnpj", :header => "CNPJ") do |record|
    record.cnpj
  end

  # column(:user, :header => "Intermediador") do |record|
  #   if record.users && record.users.length > 0
  #     record.users.pluck(:name).join(', ')
  #   end
  # end

  column(:user, :header => "Intermediador") do |record|
    if record.user
      record.user.name
    end
  end

  column(:title, :order => "title", :header => "Título da proposta") do |record|
    record.title
  end

  column(:observation, :order => "observation", :header => "Observações gerais") do |record|
    record.observation
  end

  column(:proposal_situation, :order => "proposal_situations.name", :header => "Situação") do |record|
    if record.proposal_situation
      record.proposal_situation.name
    end
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
