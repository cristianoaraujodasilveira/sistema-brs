class CreateBiddingProposals < ActiveRecord::Migration
  def change
    create_table :bidding_proposals do |t|
      t.references :bidding, index: true, foreign_key: true
      t.references :price_offer, index: true, foreign_key: true
      t.string :another_price_offer
      t.references :registration_form, index: true, foreign_key: true
      t.boolean :technical_offer
      t.references :judgment_form, index: true, foreign_key: true
      t.string :quoted_value
      t.string :discount_percent
      t.string :item_number
      t.text :description
      t.integer :quantity
      t.string :unitary_value
      t.string :total_value
      t.string :global_value
      t.string :partner_rank_text
      t.references :partner_rank, index: true, foreign_key: true
      t.references :participation_result, index: true, foreign_key: true
      t.references :competition_status, index: true, foreign_key: true
      t.string :auctioned_value
      t.references :unit, index: true, foreign_key: true
      t.string :traded_value
      t.string :bidder_name
      t.string :representative_name
      t.string :cnpj
      t.string :past_due
      t.references :bidder_status, index: true, foreign_key: true
      t.string :another_bidder_status
      t.references :provenance, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.string :site

      t.timestamps null: false
    end
  end
end
