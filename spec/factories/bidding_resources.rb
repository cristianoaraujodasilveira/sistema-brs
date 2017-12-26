FactoryGirl.define do
	factory :bidding_resource do
		association :bidding
		association :bidding_proposal
		type 1
		initial_date {Faker::Date.between(7.days.ago, Date.today)}
		final_date {Faker::Date.between(7.days.ago, Date.today)}
		insertion_portal_date {Faker::Date.between(7.days.ago, Date.today)}
		association :result
	end
end
