require 'cpf_faker'

FactoryGirl.define do
	factory :third do
		register_number {Faker::Number.number(6)}
		name {Faker::Name.name}
		fantasy_name {Faker::Company.buzzword}
		social_name {Faker::Company.name}
		rg {Faker::Number.number(8)}
		cpf {Faker::CPF.numeric}
		association :diligent_profile
		association :third_type
	end
end
