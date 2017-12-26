class ClientDocumentsGrid

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
    ClientDocument.includes(:client_document_type).includes(:client_document_notification).order(:client_document_type_id).order(created_at: :desc)
  end

  column(:document, :html => true, :header => "Documento") do |record|
    record.type_show_grid = 2
    render "show_document", :object => record
  end

  column(:client_document_type, :header => "Tipo") do |record|
    if record.client_document_type
      record.client_document_type.name
    end
  end

  column(:due_date, :header => "Vencimento") do |record|
    if record.due_date
      I18n.l(record.due_date.to_date, format: :default)
    end
  end

  column(:client_document_notification, :header => "Notificação com") do |record|
    if record.client_document_notification
      record.client_document_notification.days.to_s + " dias"
    end
  end

end
