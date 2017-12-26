FactoryGirl.define do
	factory :email do
		association :emailtable, factory: :profile
		email {Faker::Internet.email}
	end
end
