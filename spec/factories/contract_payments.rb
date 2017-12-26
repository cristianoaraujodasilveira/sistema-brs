FactoryGirl.define do
	factory :contract_payment do
		association :contract
		association :payment_form
		association :payment_from
		association :payment_sugestion_day
	end
end
