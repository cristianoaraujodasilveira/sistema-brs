FactoryGirl.define do
	factory :monthly_value do
		association :proposal 
		percentual_discounts {Faker::Commerce.price}
		observation {Faker::Lorem.paragraph}
	end
end
