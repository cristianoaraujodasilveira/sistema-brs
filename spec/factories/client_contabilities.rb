FactoryGirl.define do
	factory :client_contability do
		name {Faker::Name.name}
		zipcode {Faker::Address.zip_code}
		address {Faker::Address.street_address}
		district {Faker::Address.street_name}
		number {Faker::Number.number(3)}
		complement {Faker::Address.secondary_address}
		association :client
		association :state
		association :city 
	end
end
