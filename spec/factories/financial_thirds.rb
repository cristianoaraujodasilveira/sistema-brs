FactoryGirl.define do
	factory :financial_third do
		association :financial_third_service
		association :financial
		association :third_type
		association :third
		association :lawyer

		name {Faker::Name.name}
		fantasy_name {Faker::Company.buzzword}
		social_name {Faker::Company.name}
		quantity {Faker::Number.number(8)}
		value {Faker::Number.decimal(2)}
		date {Faker::Date.between(30.days.ago, Date.today)}
	end
end
