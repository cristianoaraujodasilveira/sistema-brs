FactoryGirl.define do
	factory :phone do
		association :phonetable, factory: :profile
		phone {Faker::PhoneNumber.cell_phone}
	end
end
