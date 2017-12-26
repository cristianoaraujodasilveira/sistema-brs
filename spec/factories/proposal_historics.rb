FactoryGirl.define do
	factory :proposal_historic do
		comment {Faker::Lorem.paragraph}
		association :proposal
		association :user
	end
end
