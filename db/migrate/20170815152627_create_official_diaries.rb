class CreateOfficialDiaries < ActiveRecord::Migration
  def change
    create_table :official_diaries do |t|
      t.references :user, index: true, foreign_key: true
      t.references :sphere, index: true, foreign_key: true

      t.string :name
      t.string :social_name
      t.string :cnpj
      t.string :phone_brs
      t.string :email_brs
      t.string :site

      t.timestamps null: false
    end
  end
end
