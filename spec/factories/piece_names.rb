FactoryGirl.define do
  factory :piece_name do
    name {Faker::Name.name}
  end
end
