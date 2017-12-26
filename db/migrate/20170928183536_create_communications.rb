class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :communication_status, index: true, foreign_key: true
      t.references :department_notified, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true
      t.references :organ, index: true, foreign_key: true
      t.references :modalidate, index: true, foreign_key: true
      t.string :subject
      t.text :description
      t.string :modalidate_number

      t.timestamps null: false
    end
  end
end
