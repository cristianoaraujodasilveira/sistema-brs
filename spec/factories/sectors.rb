FactoryGirl.define do
	factory :sector do
		name {Faker::Name.name}
		office {Faker::Company.profession}
		observation {Faker::Lorem.paragraph}
		responsible_name {Faker::Name.name}
		association :organ
	end
end
