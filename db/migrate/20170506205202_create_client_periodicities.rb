class CreateClientPeriodicities < ActiveRecord::Migration
  def change
    create_table :client_periodicities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
