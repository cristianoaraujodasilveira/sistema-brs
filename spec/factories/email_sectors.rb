FactoryGirl.define do
	factory :email_sector do
		email {Faker::Internet.email}
		association :sector
	end
end
