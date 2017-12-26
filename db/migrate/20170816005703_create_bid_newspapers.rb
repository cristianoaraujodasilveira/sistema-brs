class CreateBidNewspapers < ActiveRecord::Migration
  def change
    create_table :bid_newspapers do |t|

      t.references :user, index: true, foreign_key: true
      t.references :client, index: true, foreign_key: true

      t.string :name
      t.string :social_name
      t.string :cnpj
      t.date :initial_date
      t.date :final_date
      t.string :phone_brs
      t.string :email_brs
      t.string :site

      t.timestamps null: false
    end
  end
end
