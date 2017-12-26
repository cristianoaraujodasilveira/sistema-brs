class CreateContabilitySecondaryContacts < ActiveRecord::Migration
  def change
    create_table :contability_secondary_contacts do |t|
      t.string :name
      t.references :client_contability, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
