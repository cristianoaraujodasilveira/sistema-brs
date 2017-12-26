FactoryGirl.define do
	factory :email_user do
		email {Faker::Internet.email}
		association :user
	end
end
