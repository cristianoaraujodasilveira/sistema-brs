FactoryGirl.define do
  factory :client_contact do
    responsible_name {Faker::Name.name}
    zipcode {Faker::Address.zip_code}
    address {Faker::Address.street_address}
    district {Faker::Address.street_name}
    number {Faker::Number.number(3)}
    complement {Faker::Address.secondary_address}
    office {Faker::Company.profession}
    department {Faker::Company.name}
    whatsapp {Faker::PhoneNumber.phone_number}
    skype {Faker::Beer.name}
    association :state
    association :city 
    association :client 
  end
end
