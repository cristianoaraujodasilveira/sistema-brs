FactoryGirl.define do
	factory :responsible do
		association :responsibletable, factory: :profile

		name {Faker::Name.name}
		office {Faker::Company.profession}
		department {Faker::Company.name}
		whatsapp {Faker::PhoneNumber.phone_number}
		skype {Faker::Beer.name}
		phone {Faker::PhoneNumber.cell_phone}
		email {Faker::Internet.email}
		type {Faker::Number.number(1)}
	end
end
