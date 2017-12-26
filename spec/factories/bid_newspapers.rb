require 'cpf_faker'

FactoryGirl.define do
	factory :bid_newspaper do
		association :user
		association :client

		name {Faker::Name.name}
		initial_date {Faker::Date.between(7.days.ago, Date.today)}
		final_date {Faker::Date.between(7.days.ago, Date.today)}
		social_name {Faker::Company.name}
		cnpj {Faker::CNPJ.pretty}
		phone_brs {Faker::PhoneNumber.phone_number}
		email_brs {Faker::Internet.email}
		site {Faker::Internet.url}
	end
end
