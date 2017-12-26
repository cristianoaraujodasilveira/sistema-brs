FactoryGirl.define do
	factory :financial do
		association :client
		association :contract
		indication_value {Faker::Number.number(5)}
		indication_pessoal {Faker::Name.name}
	end
end
