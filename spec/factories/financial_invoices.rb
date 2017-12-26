FactoryGirl.define do
  factory :financial_invoice do
    bidding nil
    emission_date "2017-09-29"
    certify_date "2017-09-29"
    due_date_payment "2017-09-29"
    total_value "MyString"
    organ_value "MyString"
    received_value "MyString"
    residual_value "MyString"
    payment_date_residual "2017-09-29"
    liquidation_date "2017-09-29"
    payment_partner_date "2017-09-29"
  end
end
