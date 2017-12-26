require 'cpf_faker'

FactoryGirl.define do
	factory :official_diary do
		association :user
		association :sphere
		
		name {Faker::Name.name}
		social_name {Faker::Company.name}
		cnpj {Faker::CNPJ.pretty}
		phone_brs {Faker::PhoneNumber.cell_phone}
		email_brs {Faker::Internet.email}
		site {Faker::Internet.domain_name}
	end
end
