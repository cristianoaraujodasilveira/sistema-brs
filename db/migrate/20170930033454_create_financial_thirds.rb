class CreateFinancialThirds < ActiveRecord::Migration
  def change
    create_table :financial_thirds do |t|
      t.references :financial, index: true, foreign_key: true
      t.references :third_type, index: true, foreign_key: true
      t.references :third, index: true, foreign_key: true
      t.references :lawyer, index: true, foreign_key: true
      t.references :financial_third_service, index: true, foreign_key: true
      t.string :name
      t.string :fantasy_name
      t.string :social_name
      t.string :value
      t.string :quantity
      t.date :date

      t.timestamps null: false
    end
  end
end
