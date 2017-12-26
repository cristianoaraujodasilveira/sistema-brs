FactoryGirl.define do
	factory :country do
		name {Faker::Name.name}
	end
end
