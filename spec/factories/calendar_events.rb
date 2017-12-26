FactoryGirl.define do
  factory :calendar_event do
    association :entity_class
    name {Faker::Name.name}
    association :user
    association :calendar_color
    association :calendar_type_event
    shared false
    zipcode {Faker::Address.zip_code}
    address {Faker::Address.street_address}
    district {Faker::Address.street_name}
    number {Faker::Number.number(3)}
    complement {Faker::Address.secondary_address}
    association :state
    association :city
    send_notification false
    repeat false
    quantity_repetition {Faker::Number.number(2)}
    association :calendar_repetition
    observation {Faker::Lorem.paragraph}

    initial_date {Faker::Date.between(Date.today, 30.days.from_now)}

    initial_time "13:00:00"
    final_time "17:00:00"
  end
end
