class CreateThirds < ActiveRecord::Migration
  def change
    create_table :thirds do |t|
      t.string :register_number
      t.string :name
      t.string :fantasy_name
      t.string :social_name
      t.string :rg
      t.string :cpf
      t.references :diligent_profile, index: true, foreign_key: true
      t.references :third_type, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_column :responsibles, :site, :string
  end
end
