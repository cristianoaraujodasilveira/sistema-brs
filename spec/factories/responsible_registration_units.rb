FactoryGirl.define do
	factory :responsible_registration_unit do
		association :registration_unit
		name {Faker::Name.name}
		office {Faker::Company.profession}
		department {Faker::Company.name}
		whatsapp {Faker::PhoneNumber.phone_number}
		skype {Faker::Beer.name}
	end
end
