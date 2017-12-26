FactoryGirl.define do
    factory :portal do
        association :user
        association :client

        name {Faker::Name.name}
        initial_date {Faker::Date.between(7.days.ago, Date.today)}
        final_date {Faker::Date.between(7.days.ago, Date.today)}
        site {Faker::Internet.url}
        phone {Faker::PhoneNumber.phone_number}
        email {Faker::Internet.email}
        responsible {Faker::Name.name}
        registration_unit {Faker::Name.name}
    end
end
