require 'cpf_faker'

FactoryGirl.define do
  factory :visits_report do
    association :client
    date_and_time {Faker::Time.forward(23, :morning)}
    association :scale 
    subject {Faker::Lorem.word}
    site {Faker::Internet.url}
    responsible_name {Faker::Lorem.word}
    intermediary {Faker::Lorem.word}
    contacts {Faker::Lorem.word}
    phone {Faker::PhoneNumber.cell_phone}
    email {Faker::Internet.email}
    segment {Faker::Lorem.word}
    cnpj {Faker::CNPJ.numeric}
    products_and_services {Faker::Lorem.word}
    bid_participant 'Não'
    participate_brs 'Sim'
    observation {Faker::Lorem.paragraph}
    association :user 
    zipcode {Faker::Address.zip_code}
    address {Faker::Address.street_name}
    district {Faker::Lorem.word}
    number {Faker::Address.building_number}
    complement {Faker::Address.secondary_address}
    association :state
    association :city
    social_name {Faker::Company.name}
    fantasy_name {Faker::Company.name}
    proposal_text {Faker::Name.title}
end
end
