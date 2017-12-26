FactoryGirl.define do
  factory :client_class do
    name {Faker::Name.name}
  end
end
