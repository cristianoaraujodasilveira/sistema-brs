class CreateFinancialInvoices < ActiveRecord::Migration
  def change
    create_table :financial_invoices do |t|
      t.references :bidding, index: true, foreign_key: true
      t.date :emission_date
      t.date :certify_date
      t.date :due_date_payment
      t.string :total_value
      t.string :organ_value
      t.string :received_value
      t.string :residual_value
      t.date :payment_date_residual
      t.date :liquidation_date
      t.date :payment_partner_date

      t.timestamps null: false
    end
  end
end
