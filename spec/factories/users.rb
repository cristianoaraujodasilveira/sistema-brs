require 'cpf_faker'

FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
    recovery_token {SecureRandom.urlsafe_base64}
    last_access {DateTime.now}
    zipcode {Faker::Address.zip_code}
    address {Faker::Address.street_address}
    district {Faker::Address.street_name}
    number {Faker::Number.number(3)}
    complement {Faker::Address.secondary_address}
    office {Faker::Company.profession}
    department {Faker::Company.name}
    rg {Faker::Number.number(8)}
    cpf {Faker::CPF.numeric}
    birth_date {Faker::Date.between(7.days.ago, Date.today)}
    whatsapp {Faker::PhoneNumber.phone_number}
    skype {Faker::Beer.name}
    is_blocked false
    association :state
    association :city 
    association :office_state, factory: :state
    association :office_city, factory: :city
    association :profile 
    association :calendar_color 

    after :build do |user|
        user.phone_users << build(:phone_user, :user => user)
        user.email_users << build(:email_user, :user => user)
    end
end
end
