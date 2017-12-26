FactoryGirl.define do
	factory :entity_class do
		name {Faker::Name.name}
		description {Faker::Lorem.paragraph}
		zipcode {Faker::Address.zip_code}
		address {Faker::Address.street_address}
		district {Faker::Address.street_name}
		number {Faker::Number.number(3)}
		complement {Faker::Address.secondary_address}
		association :state
		association :city 
	end
end
