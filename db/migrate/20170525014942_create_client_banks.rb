class CreateClientBanks < ActiveRecord::Migration
  def change
    create_table :client_banks do |t|
      t.string :owner_account
      t.string :bank_name
      t.string :bank_code
      t.string :agency_number
      t.string :agency_name
      t.string :cnpj
      t.string :operation
      t.references :account_bank_type, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
