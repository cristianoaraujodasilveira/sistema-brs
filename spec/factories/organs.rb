require 'cpf_faker'

FactoryGirl.define do
  factory :organ do
    name {Faker::Name.name}
    cnpj {Faker::CNPJ.numeric}
    site {Faker::Internet.domain_name}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.cell_phone}
    eletronic_portal {Faker::Internet.domain_name}
    address {Faker::Address.street_address}
    zipcode {Faker::Address.zip_code}
    district {Faker::Address.street_name}
    number {Faker::Number.number(3)}
    complement {Faker::Address.secondary_address}
    identification_number {Faker::Number.number(6)}
    observation {Faker::Lorem.paragraph}
    association :state
    association :city 
    association :sphere

    trait :with_branchs do
        after :build do |organ|
            organ.organs << build(:organ, :organ => organ)
        end
    end
    
    trait :with_sectors do
        after :build do |organ|
            organ.sectors << build(:sector, :organ => organ)
        end
    end
  end
end
