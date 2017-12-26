class CreateBiddingResources < ActiveRecord::Migration
  def change
    create_table :bidding_resources do |t|
      
      t.references :bidding, index: true, foreign_key: true
      t.references :bidding_proposal, index: true, foreign_key: true
      t.integer :type
      t.datetime :initial_date
      t.datetime :final_date
      t.datetime :insertion_portal_date
      t.references :result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
