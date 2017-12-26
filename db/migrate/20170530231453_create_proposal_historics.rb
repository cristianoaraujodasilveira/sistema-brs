class CreateProposalHistorics < ActiveRecord::Migration
  def change
    create_table :proposal_historics do |t|
      t.text :comment
      t.references :proposal, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
