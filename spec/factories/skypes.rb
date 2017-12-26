FactoryGirl.define do
	factory :skype do
		association :skypetable, factory: :profile
		skype {Faker::Name.name}
	end
end
