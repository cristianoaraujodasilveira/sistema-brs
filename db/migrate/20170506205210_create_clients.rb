class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.attachment :logo
      t.attachment :stamp
      t.string :social_name
      t.string :fantasy_name
      t.string :cnpj
      t.string :site
      t.string :municipal_registration
      t.string :state_registration
      t.boolean :bid_participant
      t.boolean :needs_update
      t.references :client, index: true, foreign_key: true
      t.references :client_children, references: :clients
      t.references :client_company_size, index: true, foreign_key: true
      t.references :client_periodicity, index: true, foreign_key: true
      t.references :client_type, index: true, foreign_key: true
      t.references :client_status, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end
