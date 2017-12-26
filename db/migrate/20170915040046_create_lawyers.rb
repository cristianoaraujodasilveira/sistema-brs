class CreateLawyers < ActiveRecord::Migration
  def change
    create_table :lawyers do |t|
      t.references :lawyer_type, index: true, foreign_key: true
      t.string :name
      t.string :office
      t.datetime :created_date
      t.string :cpf
      t.string :cnpj
      t.string :oab
      t.string :municipal_registration
      t.references :honorary_form, index: true, foreign_key: true
      t.string :honorary_value

      t.timestamps null: false
    end
  end
end
