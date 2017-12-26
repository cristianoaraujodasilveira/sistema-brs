FactoryGirl.define do
    factory :piece do
        association :piece_name
        association :judicial_type
        initial_date {Faker::Date.between(30.days.ago, Date.today)}
        deadline {Faker::Date.between(30.days.ago, Date.today)}
        association :piece_result
        association :client
        association :organ
        number {Faker::Number.number(6)}
        process {Faker::Number.number(6)}
        protocol_number {Faker::Number.number(6)}
        association :shipping_type
        association :piece_situation
        association :modalidate
    end
end
