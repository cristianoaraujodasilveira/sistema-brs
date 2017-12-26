FactoryGirl.define do
	factory :bidding_responsible do
		association :bidding
		association :user
		initial_date {Faker::Date.between(10.days.ago, Date.today)}
		final_date {Faker::Date.between(10.days.ago, Date.today)}
	end
end
