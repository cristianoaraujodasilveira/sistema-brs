class CreateClientDocuments < ActiveRecord::Migration
  def change
    create_table :client_documents do |t|
      t.attachment :document
      t.date :due_date
      t.references :client, index: true, foreign_key: true
      t.references :client_document_type, index: true, foreign_key: true
      t.references :client_document_status, index: true, foreign_key: true
      t.references :client_document_notification, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
