FactoryGirl.define do
	factory :entity_class_responsible do
		association :entity_class
		name {Faker::Name.name}
		office {Faker::Company.profession}
		department {Faker::Company.name}
		whatsapp {Faker::PhoneNumber.phone_number}
		skype {Faker::Beer.name}
	end
end
