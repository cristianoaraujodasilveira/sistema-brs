FactoryGirl.define do
	factory :contability_contact do
		name {Faker::Name.name}
		association :client_contability
	end
end
