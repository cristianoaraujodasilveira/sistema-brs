FactoryGirl.define do
  factory :scale do
    name {Faker::Name.first_name}
  end
end
