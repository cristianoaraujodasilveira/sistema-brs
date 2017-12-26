class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.references :client, index: true, foreign_key: true
      t.references :proposal_situation, index: true, foreign_key: true
      t.text :observation
      t.text :notes
      t.string :title
      t.string :cnpj
      t.string :social_name
      t.string :fantasy_name
      t.string :proposed_value
      t.string :closed_value
      t.string :minimum_value
      t.string :proposed_percentage
      t.string :closed_percentage
      t.string :minimum_percentage
      t.string :commission_percentage

      t.timestamps null: false
    end
  end
end
