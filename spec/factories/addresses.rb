FactoryGirl.define do
	factory :address do
		association :addresstable, factory: :profile

		zipcode {Faker::Address.zip_code}
		address {Faker::Address.street_address}
		district {Faker::Address.street_name}
		number {Faker::Number.number(3)}
		complement {Faker::Address.secondary_address}
		association :state
		association :city
		type {Faker::Number.number(1)}
	end
end
