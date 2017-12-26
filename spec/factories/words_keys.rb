FactoryGirl.define do
	factory :words_key do
		word {Faker::Name.name}
	end
end
