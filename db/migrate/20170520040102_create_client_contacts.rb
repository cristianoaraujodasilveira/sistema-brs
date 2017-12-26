class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.string :zipcode
      t.string :address
      t.string :number
      t.string :complement
      t.string :district
      t.string :responsible_name
      t.string :office
      t.string :department
      t.string :whatsapp
      t.string :skype
      t.references :client, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :client_contact_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
