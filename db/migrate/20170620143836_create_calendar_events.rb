class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.references :calendar_event, index: true, foreign_key: true
      t.references :entity_class, index: true, foreign_key: true
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :calendar_color, index: true, foreign_key: true
      t.references :calendar_type_event, index: true, foreign_key: true
      t.boolean :shared
      t.string :zipcode
      t.string :address
      t.string :district
      t.string :number
      t.string :complement
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.boolean :send_notification
      t.boolean :repeat
      t.integer :quantity_repetition
      t.references :calendar_repetition, index: true, foreign_key: true
      t.text :observation

      t.date :initial_date
      t.time :initial_time
      t.time :final_time

      t.timestamps null: false
    end
  end
end
