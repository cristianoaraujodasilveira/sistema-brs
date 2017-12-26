FactoryGirl.define do
	factory :phone_user do
		phone {Faker::PhoneNumber.cell_phone}
		association :user 
	end
end
