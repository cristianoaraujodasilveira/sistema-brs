FactoryGirl.define do
	factory :phone_sector do
		phone {Faker::PhoneNumber.cell_phone}
		extension {Faker::PhoneNumber.extension}
		association :sector
	end
end
