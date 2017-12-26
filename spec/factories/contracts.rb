FactoryGirl.define do
	factory :contract do
		
		association :client
		title {Faker::Name.title}
		monthly_fixed_payment {Faker::Number.decimal(2)}
		monthly_payment {Faker::Number.decimal(2)}
		monthly_discount {Faker::Number.decimal(2)}
		monthly_initial_date {Faker::Date.between(30.days.ago, Date.today)}
		monthly_final_date {Faker::Date.between(30.days.ago, Date.today)}
		comission_fixed_payment {Faker::Number.decimal(2)}
		comission_payment {Faker::Number.decimal(2)}
		comission_discount {Faker::Number.decimal(2)}
		comission_initial_date {Faker::Date.between(30.days.ago, Date.today)}
		comission_final_date {Faker::Date.between(30.days.ago, Date.today)}
		fixed_value {Faker::Number.decimal(2)}
		comission_value {Faker::Number.decimal(2)}
		discount_value {Faker::Number.decimal(2)}
		pre_established_initial_date {Faker::Date.between(30.days.ago, Date.today)}
		pre_established_final_date {Faker::Date.between(30.days.ago, Date.today)}
		undetermined true
		draft_contact {Faker::Lorem.paragraph}
		association :proposal
		
		after(:build) do |contract|
            contract.users << build(:user)
		end
	end
end
