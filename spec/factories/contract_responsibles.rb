FactoryGirl.define do
	factory :contract_responsible do
		association :contract
		name {Faker::Name.name}
		office {Faker::Company.profession}
		department {Faker::Company.name}
		whatsapp {Faker::PhoneNumber.phone_number}
		skype {Faker::Beer.name}
	end
end
