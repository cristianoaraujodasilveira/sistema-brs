class ClientsGrid

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

  filter(:cnpj_, :string, :header => "CNPJ") do |value|
    self.where("cnpj LIKE ?", "%#{value}%")
  end

  filter(:client_class, :enum, :select => proc { ClientClass.all.order(:id).map {|c| [c.name, c.id] }}, :header => "Matriz/Filial") do |value|
    self.where("client_class_id = ?", value)
  end 

  filter(:client_type_id, :enum, :select => proc { ClientType.all.order(:name).map {|c| [c.name, c.id] }}, :header => "Tipo") do |value|
    self.where("client_type_id = ?", value)
  end 

  filter(:client_status_id, :enum, :select => proc { ClientStatus.all.order(:name).map {|c| [c.name, c.id] }}, :header => "Status") do |value|
    self.where("client_status_id = ?", value)
  end 

  scope do
    Client.includes(:client_type).includes(:client_status).includes(:client_documents).includes(:client_class).includes(:proposal).order(:social_name)
  end

  column(:visits_report, :html => true, :header => "ID Relatório de Visita") do |record|
    if record.proposal
      render "proposals/show_visits_report", :object => record.proposal.visits_report
    else
      'Proposta não selecionada'
    end
  end

  column(:fantasy_name, :html => true, :order => "fantasy_name", :header => "Nome Fantasia") do |record|
    render "show_client", :object => record, :type => 1
  end

  column(:show_client, :html => true, :order => "social_name", :header => "Razão Social") do |record|
    render "show_client", :object => record, :type => 2
  end

  column(:cnpj_, :order => "cnpj", :header => "CNPJ") do |record|
    record.cnpj
  end

  column(:client_class_client, :order => "client_classes.name", :header => "Matriz/Filial") do |record|
    if record.client_class
      record.client_class.name
    end
  end

  column(:client_type, :order => "client_types.name", :header => "Tipo") do |record|
    if record.client_type
      record.client_type.name
    else
      'Não selecionado'
    end
  end

  column(:client_status, :order => "client_statuses.name", :header => "Status") do |record|
    if record.client_status
      record.client_status.name
    else
      'Não selecionado'
    end
  end

  # column(:show_document, :html => true, :header => "Último Doc. Primário") do |record|
  #   document = record.client_documents.where(:client_document_type => 1).order(created_at: :desc).first
  #   if document
  #     document.type_show_grid = 1
  #   end
  #   render "show_document", :object => document
  # end

  # column(:show_document, :html => true, :header => "Último Doc. Secundário") do |record|
  #   document = record.client_documents.where(:client_document_type => 2).order(created_at: :desc).first
  #   if document
  #     document.type_show_grid = 1
  #   end
  #   render "show_document", :object => document
  # end

  # column(:show_document, :html => true, :header => "Último CRC") do |record|
  #   document = record.client_documents.where(:client_document_type => 3).order(created_at: :desc).first
  #   if document
  #     document.type_show_grid = 1
  #   end
  #   render "show_document", :object => document
  # end

  column(:document, :html => true, :header => "Documentos") do |record|
    render "show_all_documents", :object => record
  end

  column(:actions, :html => true, :header => "Ações") do |record|
    render "datagrid_actions", :object => record
  end

end
