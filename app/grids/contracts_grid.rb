class ContractsGrid

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
    Contract.includes(:proposal).includes(:users).includes(:contract_responsibles).includes(:user).includes(contract_responsibles: :phone_users).order(:title)
  end

  filter(:fantasy_name, :string, :header => "Nome fantasia") do |value|
    self.joins(:proposal).where("proposals.fantasy_name LIKE ?", "%#{value}%")
  end

  filter(:proposals_social_name, :string, :header => "Razão Social") do |value|
    self.joins(:proposal).where("proposals.social_name LIKE ?", "%#{value}%")
  end

  filter(:proposal_id, :enum, :select => proc { Proposal.all.order('lower(social_name)').map {|c| [c.social_name, c.id] }}, :header => "Proposta") do |value|
    self.where("proposal_id = ?", value)
  end 

  filter(:user_id, :enum, :select => proc { User.where.not(:id => 1).order('lower(name)').map {|c| [c.name, c.id] }}, :header => "Intermediador") do |value|
    self.where("user_id = ?", value)
  end 

  filter(:pre_established_initial_date, :date, :range => true, :header => "Data") do |value|
    if value[0] != nil && value[1] != nil
      self.where("pre_established_initial_date >= '#{value[0]} 00:00:00' AND pre_established_initial_date <= '#{value[1]} 23:59:59'")
    elsif value[0] != nil
      self.where("pre_established_initial_date >= '#{value[0]} 00:00:00'")
    elsif value[1] != nil
      self.where("pre_established_initial_date <= '#{value[1]} 23:59:59'")
    end
  end

  column(:visits_report, :html => true, :header => "ID Relatório de Visita") do |record|
    if record.proposal
      render "proposals/show_visits_report", :object => record.proposal.visits_report
    else
      'Proposta não selecionada'
    end
  end

  column(:fantasy_name, :html => true, :order => "proposals.fantasy_name", :header => "Nome fantasia") do |record|
    render "show_contract", :object => record, :type => 1
  end

  column(:social_name, :html => true, :order => "proposals.social_name", :header => "Razão social") do |record|
    render "show_contract", :object => record, :type => 2
  end

  column(:_cnpj, :order => "proposals.cnpj", :header => "CNPJ") do |record|
    if record.proposal
      record.proposal.cnpj
    else
      "Proposta não selecionada"
    end
  end

  # column(:users, :order => "users.name", :header => "Intermediador") do |record|
  #   if record.users && record.users.length > 0
  #     record.users.pluck(:name).join(', ')
  #   end
  # end

  column(:user, :order => "users.name", :header => "Intermediador") do |record|
    if record.user
      record.user.name
    end
  end

  column(:contract_responsibles, :header => "Telefone") do |record|
    record.get_phones
  end

  column(:pre_established_initial_date, :header => "Data de início do contrato") do |record|
    if record.undetermined
      "Indeterminado"
    elsif record.pre_established_initial_date
      I18n.l(record.pre_established_initial_date.to_date, format: :default)
    else
      "Sem data"
    end
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
