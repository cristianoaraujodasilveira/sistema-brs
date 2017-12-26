FactoryGirl.define do
	factory :observation do
		association :observationtable, factory: :profile
		association :user
		observation {Faker::Lorem.paragraph}
		type {Faker::Number.number(1)}
	end
end
