class CreateVisitsReports < ActiveRecord::Migration
  def change
    create_table :visits_reports do |t|
      t.references :client, index: true, foreign_key: true
      t.string :social_name
      t.datetime :date_and_time
      t.references :scale, index: true, foreign_key: true
      t.string :subject
      t.references :proposal, index: true, foreign_key: true
      t.string :proposal_text
      t.string :site
      t.string :responsible_name
      t.string :intermediary
      t.string :contacts
      t.string :phone
      t.string :email
      t.string :segment
      t.string :cnpj
      t.string :products_and_services
      t.boolean :bid_participant
      t.boolean :participate_brs
      t.text :observation
      t.references :user, index: true, foreign_key: true
      t.string :zipcode
      t.string :address
      t.string :district
      t.string :number
      t.string :complement
      t.boolean :shared
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true

      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
