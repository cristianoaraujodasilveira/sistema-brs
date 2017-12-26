FactoryGirl.define do
	factory :registration_unit do
		name {Faker::Name.name}
		site {Faker::Internet.domain_name}
		
		zipcode {Faker::Address.zip_code}
		address {Faker::Address.street_address}
		district {Faker::Address.street_name}
		number {Faker::Number.number(3)}
		complement {Faker::Address.secondary_address}
		association :state
		association :city 
		association :organ 

		trait :with_units do
			after :build do |reg_unit|
				reg_unit.registration_units << build(:registration_unit, :registration_unit => reg_unit)
			end
		end

		trait :with_responsibles do
			after :build do |reg_unit|
				reg_unit.responsible_registration_units << build(:responsible_registration_unit, :registration_unit => reg_unit)
			end
		end
	end
end
